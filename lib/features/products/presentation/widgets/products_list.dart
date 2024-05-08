import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricer/core/constants/enums.dart';
import 'package:pricer/core/widgets/loading.dart';
import 'package:pricer/features/products/presentation/bloc/products_bloc.dart';
import 'package:pricer/features/products/presentation/widgets/product_widget.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../data/entity/product_model.dart';

class ProductsList extends StatelessWidget {
  final SiteTypes types;

  const ProductsList({super.key, required this.types});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state.status == ProductStatus.error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) {
                  return ErrorDialog(message: state.message ?? '');
                },
              );
            });
          }
        }, builder: (context, state) {
      if (state.scrapingModel != null &&
          getProductList(types, state.scrapingModel) != null) {
        return SingleChildScrollView(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              ProductModel? productModel =
              getProductList(types, state.scrapingModel)?[index];
              return  productModel == null || productModel.title == 'null' ||
                  productModel.title == null ||
                  productModel.title?.isEmpty == true || productModel.price==null

                  ? const SizedBox.shrink()
                  :  const Divider(
                height: 2,
                color: Colors.grey,
              );
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: getProductList(types, state.scrapingModel)?.length ?? 0,
            itemBuilder: (context, index) {
              ProductModel? productModel =
              getProductList(types, state.scrapingModel)?[index];
              return productModel == null || productModel.title == 'null' ||
                  productModel.title == null ||
                  productModel.title?.isEmpty == true || productModel.price==null

              ? const SizedBox.shrink()
                  : ProductWidget(productModel
              :
              productModel
              );
            },
          ),
        );
      } else {
        return const LottieWidget(type: LottieType.empty);
      }
    });
  }

  List<ProductModel>? getProductList(SiteTypes types,
      ScrapingModel? scrapingModel) {
    switch (types) {
      case SiteTypes.newProducts:
        return scrapingModel?.newProducts;

      case SiteTypes.usedProducts:
        return scrapingModel?.dubizzleProducts;
    }
  }
}
