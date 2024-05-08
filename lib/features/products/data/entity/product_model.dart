class ScrapingModel {
  List<ProductModel>? newProducts;
  List<ProductModel>? dubizzleProducts;

  ScrapingModel(
      {this.newProducts,

        this.dubizzleProducts});

  ScrapingModel.fromJson(Map<String, dynamic> json) {
    newProducts = <ProductModel>[];

    if (json['amazon_products'] != null) {
      json['amazon_products'].forEach((v) {
        newProducts!.add(ProductModel.fromJson(v));
      });
    }
    if (json['noon_products'] != null) {
      json['noon_products'].forEach((v) {
        newProducts!.add(ProductModel.fromJson(v));
      });
    }
    if (json['btech_products'] != null) {
      json['btech_products'].forEach((v) {
        newProducts!.add(ProductModel.fromJson(v));
      });
    }
    if (json['dubizzle_products'] != null) {
      dubizzleProducts = <ProductModel>[];
      json['dubizzle_products'].forEach((v) {
        dubizzleProducts!.add(ProductModel.fromJson(v));
      });
    }
  }

}

class ProductModel {
  String? title;
  double? price;
  String? image;
  String? link;

  ProductModel({this.title, this.price, this.image, this.link});

  ProductModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = double.tryParse(json['price'].toString());
    image = json['image'].toString().trim();
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[ 'title'] = title;
    data['price'] = price;
    data['image'] = image;
    data['link'] = link;
    return data;
  }
}