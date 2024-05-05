import 'package:get_it/get_it.dart';
import 'package:pricer/data/helpers/cache_helper.dart';
import 'package:pricer/features/auth/data/repository/auth_repository.dart';
import 'package:pricer/features/home/data/repository/profileRepository.dart';
import 'package:pricer/features/products/data/repository/product_repository.dart';

final serviceLocator=GetIt.instance;

Future<void>setupServiceLocator()async {
  serviceLocator.registerFactory<AuthRepositoryImplementation>(() => AuthRepositoryImplementation());
  serviceLocator.registerFactory<ProductRepositoryImplementation>(() => ProductRepositoryImplementation());
  serviceLocator.registerFactory<ProfileRepositoryImplementation>(() => ProfileRepositoryImplementation());
  serviceLocator.registerSingleton<CacheHelper>(CacheHelper());
  
}