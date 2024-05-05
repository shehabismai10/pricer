import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:pricer/core/failure/failure.dart';
import 'package:pricer/core/serviceLocator/service_locator.dart';
import 'package:pricer/core/success/success.dart';
import 'package:pricer/data/helpers/cache_helper.dart';
import 'package:pricer/features/auth/data/entity/user_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Success>> updateProfile(
      {required UserModel userModel});
Future<Either<Failure,Success>>pickFile();
  Future<Either<Failure, Success>> uploadImage(
      {required String filename, required Uint8List fileBytes});
}

class ProfileRepositoryImplementation implements ProfileRepository {
  @override
  Future<Either<Failure, Success>> updateProfile(
      {required UserModel userModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uid)
          .update(userModel.toJson());
      return const Right(Success(message: 'Profile updated'));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, Success>> uploadImage(
      {required String filename, required Uint8List fileBytes}) async {
    try {
      String uid=serviceLocator<CacheHelper>().getData(key: 'uid');
      TaskSnapshot result = await FirebaseStorage.instance
          .ref('uploads/$filename')
          .putData(fileBytes);
      if (result.state == TaskState.success) {
        String url = await result.ref.getDownloadURL();
        FirebaseFirestore.instance .collection('users')
            .doc(uid).update({
          "image":url
        });
        return const Right(Success(message: 'Profile picture updated'));
      } else {
        return const Left(ServerFailure('Failed to upload'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> pickFile()async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        Uint8List? fileBytes = result.files.first.bytes;
        String fileName = result.files.first.name;
        log(result.files.first.size.toString());
         if (fileBytes != null) {
          return uploadImage(fileBytes: fileBytes, filename: fileName);
        } else {
          return const Left(ServerFailure('Something went wrong'));
        }
      } else {
        return const Left(ServerFailure('FILE NOT SELECTED'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
