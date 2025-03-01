
import 'package:mobi_phim/models/episodes_data.dart';

class EpisodesMovieModel {
  String? server_name;
  List<EpisodesDataModel>? server_data;

  EpisodesMovieModel({
      this.server_data,
      this.server_name});

  factory EpisodesMovieModel.fromJson(Map<String, dynamic> json) {
    List<EpisodesDataModel> listEpisodes=[];
    if(json["server_data"]!=null){
      json["server_data"].forEach((item){
        listEpisodes.add(EpisodesDataModel.fromJson(item));
      });
    }


    return EpisodesMovieModel(
        server_name: json['server_name'],
        server_data: listEpisodes,
    );
  }

}
