class UserModel {
  String? email;
  String? uid;
  String? mobile;
  String? image;
  String? name;

  UserModel({
    this.email,
    this.uid,
    this.mobile,
    this.image,
    this.name,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uid = json['uid'];
    mobile = json['mobile'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['uid'] = uid;
    data['mobile'] = mobile;
    data['image'] = image;
    data['name'] = name;
    return data;
  }
}
