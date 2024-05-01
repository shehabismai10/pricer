import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pricer/core/constants/styles.dart';
import 'package:pricer/core/widgets/custom_button.dart';
import 'package:pricer/features/products/data/entity/product_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel productModel;

  const ProductWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(productModel.image ?? ""))),
      ),
      title: Text(
        productModel.title ?? "",
        style: regularTextStyle,
        overflow: TextOverflow.fade,
      ),
      subtitle: Text(
        productModel.price ?? "0",
        style: regularTextStyle.copyWith(color: Colors.green),
      ),trailing: IconButton(onPressed: () {
        launchUrl(Uri.parse(productModel.link??''));
      }, icon: const Icon(Icons.shopping_cart,color: Colors.deepPurple,)),
    );
  }
}
