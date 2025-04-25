import 'package:mongo_dart/mongo_dart.dart';

class InforMovie {
  String? profile_id;
  String? slug;
  int? episode;
  int? serverNumber;


  InforMovie({
      this.profile_id,
      this.slug,
      this.episode,
      this.serverNumber,});

  factory InforMovie.fromJson(Map<String, dynamic> json) {
    return InforMovie(
        profile_id: json['profile_id'],
        slug: json['slug_movie'],
        episode: json['episode'],
        serverNumber: json['server_number'],
    );
  }

  Map<String, dynamic> toMap() {
    var _id;
    try{
      _id=ObjectId.fromHexString(profile_id!);
    }
    catch(e){
      _id=profile_id;
    }
    if (episode!=null) {
      return {
        "profile_id": _id,
        "slug_movie": slug,
        "episode": episode,
        "server_number": serverNumber,
        "update_at": DateTime.now(),
      };
    }
    return {
      "profile_id": _id,
      "slug_movie": slug,
    };
  }
  Map<String, dynamic> findUserSlug_toMap() {
    var _id;
    try{
      _id=ObjectId.fromHexString(profile_id!);
    }
    catch(e){
      _id=profile_id;
    }
    return {
      "profile_id": _id,
      "slug_movie": slug ,
    };
  }
}
