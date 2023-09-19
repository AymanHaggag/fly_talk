class PostModel {
  String? name;
  String? dateTime;
  String? uId;
  dynamic postImage;
  dynamic postBody;


  PostModel({
    this.name,
    this.uId,
    this.postImage,
    this.dateTime,
    this.postBody
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    postImage = json["postImage"];
    dateTime = json["dateTime"];
    postBody = json["postBody"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "uId": uId,
      "postImage" : postImage,
      "dateTime" : dateTime,
      "postBody" : postBody,
    };
  }
}
