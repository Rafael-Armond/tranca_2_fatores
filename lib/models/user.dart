class UserModel {
  String? fullName;
  String? email;
  String? password;
  String? phoneNumber;
  DateTime? createdAt;

  UserModel({
    this.fullName,
    this.email,
    this.password,
    this.phoneNumber,
    this.createdAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    createdAt =
        json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['createdAt'] = createdAt?.toIso8601String();
    return data;
  }
}
