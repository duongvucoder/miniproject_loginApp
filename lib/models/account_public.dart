class AccountPublic {
  int? id;
  String? name;
  String? avatar;

  AccountPublic({this.id, this.name, this.avatar});

  AccountPublic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}
