class Photo {
  String? contentType;
  String? extension;
  String? name;
  String? size;
  String? path;

  Photo({this.contentType, this.extension, this.name, this.size, this.path});

  Photo.fromJson(Map<String, dynamic> json) {
    contentType = json['contentType'];
    extension = json['extension'];
    name = json['name'];
    size = json['size'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contentType'] = contentType;
    data['extension'] = extension;
    data['name'] = name;
    data['size'] = size;
    data['path'] = path;
    return data;
  }
}
