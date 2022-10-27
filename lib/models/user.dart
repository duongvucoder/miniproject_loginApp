class User {
  int? id;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? name;
  String? dateOfBirth;
  String? address;
  bool? gender;
  String? phoneNumber;
  String? email;
  String? avatar;
  String? token;

  User(
      {this.id,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.name,
      this.dateOfBirth,
      this.address,
      this.gender,
      this.phoneNumber,
      this.email,
      this.avatar,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
    name = json['name'];
    dateOfBirth = json['dateOfBirth'];
    address = json['address'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    avatar = json['avatar'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['modifiedAt'] = modifiedAt;
    data['modifiedBy'] = modifiedBy;
    data['name'] = name;
    data['dateOfBirth'] = dateOfBirth;
    data['address'] = address;
    data['gender'] = gender;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['avatar'] = avatar;
    data['token'] = token;
    return data;
  }
}
