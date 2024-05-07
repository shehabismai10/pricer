import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:pricer/core/constants/endpoints.dart';
import 'package:pricer/core/failure/failure.dart';
import 'package:pricer/features/products/data/entity/product_model.dart';

import '../../../../data/helpers/network_helper.dart';

abstract class ProductRepository {
  Future<Either<Failure, ScrapingModel>> getProduct({required String query});
}

class ProductRepositoryImplementation implements ProductRepository {
  @override
  Future<Either<Failure, ScrapingModel>> getProduct(
      {required String query}) async {
    try {
      final res = await NetworkHelper.post(
          endPoint: compareApi, body: {"search_string": query});
        if (res.statusCode == 200) {
        var body = json.decode(res.body);
        ScrapingModel productModel = ScrapingModel.fromJson(body);
        return Right(productModel);
      } else {
        return const Left(ServerFailure('Something went wrong'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
