
class UserModel  {
  String? id;
  String? name;
  String? urlAvatar;


  UserModel({
      this.id,
      this.name,
      this.urlAvatar,});


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        urlAvatar: json['picture']['data']['url'],
    );
  }

}
