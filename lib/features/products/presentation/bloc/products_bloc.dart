import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pricer/core/serviceLocator/service_locator.dart';
import 'package:pricer/features/products/data/entity/product_model.dart';
import 'package:pricer/features/products/data/repository/product_repository.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsState.init()) {
    on<GetProducts>(onGetProducts);
  }

  ProductRepositoryImplementation productLocator =
      serviceLocator<ProductRepositoryImplementation>();

  void onGetProducts(GetProducts event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    final result = await productLocator.getProduct(query: event.query);
    result.fold(
        (l) => emit(
            state.copyWith(message: l.message, status: ProductStatus.error)),
        (r) => emit(
            state.copyWith(scrapingModel: r, status: ProductStatus.loaded)));
  }
}
