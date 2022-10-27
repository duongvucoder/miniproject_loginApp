class NewFeed {
  int? id;
  String? createdAt;
  String? createdBy;
  String? title;
  String? content;
  List<String>? photos;
  int? status;
  bool? isEnable;
  AccountPublic? accountPublic;

  NewFeed(
      {this.id,
      this.createdAt,
      this.createdBy,
      this.title,
      this.content,
      this.photos,
      this.status,
      this.isEnable,
      this.accountPublic});

  NewFeed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    title = json['title'];
    content = json['content'];
    photos = json['photos'].cast<String>();
    status = json['status'];
    isEnable = json['isEnable'];
    accountPublic = json['accountPublic'] != null
        ? AccountPublic.fromJson(json['accountPublic'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['title'] = title;
    data['content'] = content;
    data['photos'] = photos;
    data['status'] = status;
    data['isEnable'] = isEnable;
    if (accountPublic != null) {
      data['accountPublic'] = accountPublic!.toJson();
    }
    return data;
  }
}

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
