
class UserAccountModel  {
  String? id;
  String? username;
  String? password;


  UserAccountModel({
      this.id,
      this.username,
      this.password,});


  factory UserAccountModel.fromJson(Map<String, dynamic> json) {
    return UserAccountModel(
        id: json['id'],
        username: json['username'],
        password: json['password'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "password": password ,
    };
  }

}
