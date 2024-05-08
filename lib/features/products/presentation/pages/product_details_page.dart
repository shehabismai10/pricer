import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pricer/core/constants/styles.dart';
import 'package:pricer/core/widgets/custom_button.dart';
import 'package:pricer/features/products/data/entity/product_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/colors.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailsPage({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 5).h,
              child: Stack(
                children: [
                  Hero(tag: productModel.hashCode,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: const Radius.circular(15).r,
                              bottomLeft: const Radius.circular(15).r),
                          image: DecorationImage(
                              image: NetworkImage(productModel.image ?? ""),
                              fit: BoxFit.contain)),
                    ),
                  ),
                  Positioned(left: 5.w,top: 5.h,
                    child
                        : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 20.sp,
                              color: primaryColor,
                            ))),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25.h, left: 10.0.w,top: 10.h),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    productModel.price.toString() ?? '',
                    style: standardTextStyle.copyWith(color: Colors.green),
                    textAlign: TextAlign.left,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
              child: Text(
                productModel.title ?? '',
                style: standardTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0).h,
              child: CustomButton(color: primaryColor,size: Size(250.w, 35.h),
                onPressed: () =>
                    launchUrl(Uri.parse(productModel.link??''))

                ,
                title: '',
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Buy now',
                        style: regularTextStyle.copyWith(color: Colors.white)),
                    Icon(Icons.shopping_cart,color: Colors.white,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}