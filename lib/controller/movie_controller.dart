import 'package:get/get.dart';
import 'package:mobi_phim/models/episodes_movie.dart';
import 'package:mobi_phim/models/infor_movie.dart';
import 'package:mobi_phim/services/db_mongo_service.dart';

class MovieController extends GetxController {
  Future<List> getSavedEpisode(String profileId,String slug) async {
    List? episode=await DbMongoService().getServerEpisodeContinueMovie(profileId, slug);
    // final prefs = await SharedPreferences.getInstance();
    return episode ?? [0.toString(),(-1).toString()]; // Mặc định là tập 1 nếu chưa lưu
  }
  Future<void> saveEpisode(String profileId,int serverNumber,int episodeNumber,String slug, List<EpisodesMovieModel> listEpisodes) async {

    InforMovie newMovie=InforMovie(profile_id: profileId,slug: slug,episode: episodeNumber,serverNumber: serverNumber );
    if(episodeNumber==listEpisodes[0].server_data!.length-1 ) {
      DbMongoService().removeContinueMovie(newMovie);
    }
    else{
      DbMongoService().addContinueMovie(newMovie);
    }
  }
}