class ProductModel {
  List<AmazonProducts>? amazonProducts;
  List<NoonProducts>? noonProducts;
  List<BtechProducts>? btechProducts;
  List<DubizzleProducts>? dubizzleProducts;

  ProductModel(
      {this.amazonProducts,
        this.noonProducts,
        this.btechProducts,
        this.dubizzleProducts});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['amazon_products'] != null) {
      amazonProducts = <AmazonProducts>[];
      json['amazon_products'].forEach((v) {
        amazonProducts!.add(AmazonProducts.fromJson(v));
      });
    }
    if (json['noon_products'] != null) {
      noonProducts = <NoonProducts>[];
      json['noon_products'].forEach((v) {
        noonProducts!.add(NoonProducts.fromJson(v));
      });
    }
    if (json['btech_products'] != null) {
      btechProducts = <BtechProducts>[];
      json['btech_products'].forEach((v) {
        btechProducts!.add(BtechProducts.fromJson(v));
      });
    }
    if (json['dubizzle_products'] != null) {
      dubizzleProducts = <DubizzleProducts>[];
      json['dubizzle_products'].forEach((v) {
        dubizzleProducts!.add(DubizzleProducts.fromJson(v));
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

class AmazonProducts {
  String? title;
  String? price;
  String? image;
  String? link;

  AmazonProducts({this.title, this.price, this.image, this.link});

  AmazonProducts.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['price'] = price;
    data['image'] = image;
    data['link'] = link;
    return data;
  }
}

class NoonProducts {
  int? counter;
  String? name;
  String? price;
  List<String>? image;
  String? link;

  NoonProducts({this.counter, this.name, this.price, this.image, this.link});

  NoonProducts.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    name = json['name'];
    price = json['price'];
    image = json['image'].cast<String>();
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['counter'] = counter;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['link'] = link;
    return data;
  }
}

class BtechProducts {
  int? counter;
  String? name;
  String? price;
  String? image;
  String? link;

  BtechProducts({this.counter, this.name, this.price, this.image, this.link});

  BtechProducts.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['counter'] = counter;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['link'] = link;
    return data;
  }

}
class DubizzleProducts {
  int? counter;
  String? name;
  String? price;
  String? image;
  String? link;

  DubizzleProducts(
      {this.counter, this.name, this.price, this.image, this.link});

  DubizzleProducts.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['counter'] = counter;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['link'] = link;
    return data;
  }
}
