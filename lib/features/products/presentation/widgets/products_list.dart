import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricer/core/constants/enums.dart';
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
        return ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider(
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
            return productModel == null
                ? const SizedBox.shrink()
                : ProductWidget(productModel: productModel);
          },
        );
      } else {
        return Center(
          child: Text(
            "No data found",
            style: regularTextStyle,
          ),
        );
      }
    });
  }

  List<ProductModel>? getProductList(
      SiteTypes types, ScrapingModel? scrapingModel) {
    switch (types) {
      case SiteTypes.amazon:
        return scrapingModel?.amazonProducts;
      case SiteTypes.noon:
        return scrapingModel?.noonProducts;

      case SiteTypes.dubizzle:
        return scrapingModel?.dubizzleProducts;

      case SiteTypes.btech:
        return scrapingModel?.btechProducts;
    }
  }
}
