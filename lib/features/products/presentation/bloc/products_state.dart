part of 'products_bloc.dart';

class ProductsState {
  ScrapingModel? scrapingModel;
  ProductStatus? status;
  String? message;
  bool?increment;
  ProductsState({this.message, this.scrapingModel, this.status,this.increment});

  ProductsState.init()
      : scrapingModel = null,
        message = null,
        increment=null,
        status = ProductStatus.initial;

  ProductsState copyWith(
      {ScrapingModel? scrapingModel, ProductStatus? status, String? message,bool?increment}) {
    return ProductsState(
        scrapingModel: scrapingModel ?? this.scrapingModel,
        status: status ?? this.status,
        increment: increment??this.increment,
        message: message ?? this.message);
  }
}

enum ProductStatus { initial, loading, loaded, error }
