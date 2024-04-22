import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pricer/core/constants/strings.dart';
import 'package:pricer/core/failure/failure.dart';
import 'package:pricer/features/auth/data/entity/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> success(
      {required String email, required String password});

  Future<Either<Failure, UserModel>> getUserData({required String uid});

  Future<Either<Failure, UserModel>> register(
      {required String email, required String password, required String name});

  Future<Either<Failure, UserModel>> createUser({required UserModel userModel});
}

class AuthRepositoryImplementation implements AuthRepository {
  @override
  Future<Either<Failure, UserModel>> success(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) {
        return const Left(ServerFailure(serverError));
      } else {
        final result = await getUserData(uid: userCredential.user!.uid);
        return result;
      }
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? serverError));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserData({required String uid}) async {
    try {
      var data =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (data.exists && data.data() != null) {
        UserModel userModel = UserModel.fromJson(data.data()!);
        return Right(userModel);
      } else {
        return const Left(ServerFailure(serverError));
      }
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? serverError));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) {
        return const Left(ServerFailure(serverError));
      } else {
        User user = userCredential.user!;
        UserModel userModel =
            UserModel(email: email, uid: user.uid, name: name);
        final result = await createUser(userModel: userModel);
        return result;
      }
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? serverError));
    }
  }

  @override
  Future<Either<Failure, UserModel>> createUser(
      {required UserModel userModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uid)
          .set(userModel.toJson());
      return Right(userModel);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? serverError));
    }
  }
}
