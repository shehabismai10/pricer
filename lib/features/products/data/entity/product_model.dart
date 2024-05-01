class ScrapingModel {
  List<ProductModel>? amazonProducts;
  List<ProductModel>? noonProducts;
  List<ProductModel>? btechProducts;
  List<ProductModel>? dubizzleProducts;

  ScrapingModel(
      {this.amazonProducts,
        this.noonProducts,
        this.btechProducts,
        this.dubizzleProducts});

  ScrapingModel.fromJson(Map<String, dynamic> json) {
    if (json['amazon_products'] != null) {
      amazonProducts = <ProductModel>[];
      json['amazon_products'].forEach((v) {
        amazonProducts!.add(ProductModel.fromJson(v));
      });
    }
    if (json['noon_products'] != null) {
      noonProducts = <ProductModel>[];
      json['noon_products'].forEach((v) {
        noonProducts!.add(ProductModel.fromJson(v));
      });
    }
    if (json['btech_products'] != null) {
      btechProducts = <ProductModel>[];
      json['btech_products'].forEach((v) {
        btechProducts!.add(ProductModel.fromJson(v));
      });
    }
    if (json['dubizzle_products'] != null) {
      dubizzleProducts = <ProductModel>[];
      json['dubizzle_products'].forEach((v) {
        dubizzleProducts!.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (amazonProducts != null) {
      data['amazon_products'] =
          amazonProducts!.map((v) => v.toJson()).toList();
    }
    if (noonProducts != null) {
      data['noon_products'] =
          noonProducts!.map((v) => v.toJson()).toList();
    }
    if (btechProducts != null) {
      data['btech_products'] =
          btechProducts!.map((v) => v.toJson()).toList();
    }
    if (dubizzleProducts != null) {
      data['dubizzle_products'] =
          dubizzleProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductModel {
  String? title;
  String? price;
  String? image;
  String? link;

  ProductModel({this.title, this.price, this.image, this.link});

  ProductModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    image = json['image'];
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

