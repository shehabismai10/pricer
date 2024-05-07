import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pricer/core/constants/styles.dart';
import 'package:pricer/core/widgets/custom_button.dart';
import 'package:pricer/data/helpers/navigation_helper.dart';
import 'package:pricer/features/products/data/entity/product_model.dart';
import 'package:pricer/features/products/presentation/pages/product_details_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/colors.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel productModel;

  const ProductWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 120.h,
      child: ListTile(onTap: () => navigateTo(context, ProductDetailsPage(productModel: productModel)),
        leading: Hero(tag: productModel.hashCode,
          child: Container(
            width: MediaQuery.of(context).size.width / 5,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: NetworkImage(productModel.image ?? ""))),
          ),
        ),
        title: SizedBox(height: 75.h,width: 60.w,
          child: Text(
            productModel.title ?? "",
            style: regularTextStyle,
            overflow: TextOverflow.clip,textAlign: TextAlign.left,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0).h,
          child: Text(
            productModel.price ?? "0",
            style: regularTextStyle.copyWith(color: Colors.green),
          ),
        ),trailing: IconButton(onPressed: () {
          launchUrl(Uri.parse(productModel.link??''));
        }, icon: const Icon(Icons.shopping_cart,color: primaryColor,)),
      ),
    );
  }
}
