part of 'products_bloc.dart';

class ProductsState {
  ScrapingModel? scrapingModel;
  ProductStatus? status;
  String? message;

  ProductsState({this.message, this.scrapingModel, this.status});

  ProductsState.init()
      : scrapingModel = null,
        message = null,
        status = ProductStatus.initial;

  ProductsState copyWith(
      {ScrapingModel? scrapingModel, ProductStatus? status, String? message}) {
    return ProductsState(
        scrapingModel: scrapingModel ?? this.scrapingModel,
        status: status ?? this.status,
        message: message ?? this.message);
  }
}

enum ProductStatus { initial, loading, loaded, error }
