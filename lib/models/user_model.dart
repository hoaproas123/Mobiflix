
import 'package:mongo_dart/mongo_dart.dart';

class UserModel  {
  String? id;
  String? username;
  String? name;
  String? urlAvatar;
  bool canEdit;


  UserModel({
      this.id,
      this.username,
      this.name,
      this.urlAvatar,
      this.canEdit=false,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        username: json['username'],
        name: json['name'],
        urlAvatar: json['picture']['data']['url'],
        canEdit: false,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "username": username,
      "name": name ,
      "urlImg": urlAvatar,
    };
  }

}
