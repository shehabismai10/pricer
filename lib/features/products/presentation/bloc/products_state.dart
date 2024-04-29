part of 'products_bloc.dart';

class ProductsState {
  ProductModel? productModel;
  ProductStatus? status;
  String? message;
  ProductsState({this.message,this.productModel, this.status});

  ProductsState.init()
      : productModel = null,
        status = ProductStatus.initial;

  ProductsState copyWith({ProductModel?productModel,ProductStatus?status,String?message}){
    return ProductsState(productModel: productModel??this.productModel,status: status??this.status,message: message??this.message);
  }

}

enum ProductStatus { initial, loading, loaded, error }
