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
    on<SortProducts>(onSortProducts);
  }

  ProductRepositoryImplementation productLocator =
      serviceLocator<ProductRepositoryImplementation>();

  void onGetProducts(GetProducts event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    final result = await productLocator.getProduct(query: event.query);
    result.fold(
        (l) => emit(
            state.copyWith(message: l.message, status: ProductStatus.error)),
        (r) {
          r.newProducts?.shuffle();
          emit(
              state.copyWith(scrapingModel: r, status: ProductStatus.loaded));
        });
  }

  void onSortProducts(SortProducts event,Emitter<ProductsState>emit){
    List<ProductModel> ?newTemp=state.scrapingModel?.newProducts;
    List<ProductModel> ?usedTemp=state.scrapingModel?.dubizzleProducts;
    ScrapingModel? scrapingModel=state.scrapingModel;

    if(state.increment==false||state.increment==null){
      newTemp?.sort((a, b) => (a.price??0).compareTo(b.price??0),);
      usedTemp?.sort((a, b) => (a.price??0).compareTo(b.price??0),);
    scrapingModel?.newProducts=newTemp;
    scrapingModel?.dubizzleProducts=usedTemp;
    emit(state.copyWith(scrapingModel: scrapingModel,increment: true));
    }else{
      newTemp?.sort((a, b) => (b.price??0).compareTo(a.price??0),);
      usedTemp?.sort((a, b) => (b.price??0).compareTo(a.price??0),);
       scrapingModel?.newProducts=newTemp;
      scrapingModel?.dubizzleProducts=usedTemp;

      emit(state.copyWith(scrapingModel: scrapingModel,increment: false));
    }

  }

}
