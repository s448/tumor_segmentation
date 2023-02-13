class ResponseModel {
  Data? data;
  bool? success;
  int? status;

  ResponseModel({this.data, this.success, this.status});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? urlViewer;
  String? url;
  String? displayUrl;
  int? width;
  int? height;
  int? size;
  int? time;
  int? expiration;
  Image? image;
  Image? thumb;
  String? deleteUrl;

  Data(
      {this.id,
        this.title,
        this.urlViewer,
        this.url,
        this.displayUrl,
        this.width,
        this.height,
        this.size,
        this.time,
        this.expiration,
        this.image,
        this.thumb,
        this.deleteUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    urlViewer = json['url_viewer'];
    url = json['url'];
    displayUrl = json['display_url'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
    time = json['time'];
    expiration = json['expiration'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    thumb = json['thumb'] != null ? new Image.fromJson(json['thumb']) : null;
    deleteUrl = json['delete_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url_viewer'] = this.urlViewer;
    data['url'] = this.url;
    data['display_url'] = this.displayUrl;
    data['width'] = this.width;
    data['height'] = this.height;
    data['size'] = this.size;
    data['time'] = this.time;
    data['expiration'] = this.expiration;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.thumb != null) {
      data['thumb'] = this.thumb!.toJson();
    }
    data['delete_url'] = this.deleteUrl;
    return data;
  }
}

class Image {
  String? filename;
  String? name;
  String? mime;
  String? extension;
  String? url;

  Image({this.filename, this.name, this.mime, this.extension, this.url});

  Image.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    name = json['name'];
    mime = json['mime'];
    extension = json['extension'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filename'] = this.filename;
    data['name'] = this.name;
    data['mime'] = this.mime;
    data['extension'] = this.extension;
    data['url'] = this.url;
    return data;
  }
}