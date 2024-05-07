import 'package:flutter/cupertino.dart';
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
    return Stack(
      children: [
        SizedBox(
          height: 120.h,
          child: ListTile(
            onTap: () => navigateTo(
                context, ProductDetailsPage(productModel: productModel)),
            leading: Hero(
              tag: productModel.hashCode,
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(productModel.image ?? ""))),
              ),
            ),
            title: SizedBox(
              height: 75.h,
              width: 60.w,
              child: Text(
                productModel.title ?? "",
                style: regularTextStyle,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.left,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5.0).h,
              child: Text(
                productModel.price ?? "0",
                style: regularTextStyle.copyWith(color: Colors.green),
              ),
            ),
            trailing: IconButton(
                onPressed: () {
                  launchUrl(Uri.parse(productModel.link ?? ''));
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: primaryColor,
                )),
          ),
        ),
        Positioned(
          top: 0,
          left: 5.w,
          child: Container(
            width: 80.w,
            alignment: Alignment.center,
            height: 20.h,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomRight: const Radius.circular(15).r,
                    bottomLeft: const Radius.circular(15).r)),
            child: Text(
              getSite(productModel.link ?? ''),
              style: smallTextStyle.copyWith(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}

String getSite(String link) {
  if (link.toLowerCase().contains('amazon')) {
    return 'Amazon';
  } else if (link.toLowerCase().contains('noon')) {
    return 'Noon';
  } else if (link.toLowerCase().contains("tech")) {
    return "B-tech";
  } else if (link.toLowerCase().contains('dubizzle')) {
    return 'Dubizzle';
  } else {
    return '';
  }
}
