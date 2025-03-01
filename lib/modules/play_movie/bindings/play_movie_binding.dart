
import 'package:get/get.dart';
import 'package:mobi_phim/modules/play_movie/controller/play_movie_controller.dart';


class PlayMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayMovieController(), fenix: true);
  }
}