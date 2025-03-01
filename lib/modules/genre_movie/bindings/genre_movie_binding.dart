
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/modules/genre_movie/controller/genre_movie_controller.dart';
import 'package:mobi_phim/modules/genre_movie/provider/genre_movie_provider.dart';
import 'package:mobi_phim/modules/genre_movie/repository/genre_movie_repository.dart';
import 'package:mobi_phim/services/http_provider.dart';


class GenreMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GenreMovieProvider(http: HttpProvider(httpClient: Dio())));
    Get.lazyPut(() => GenreMovieRepository(genreMovieProvider: Get.find<GenreMovieProvider>()),
        fenix: true);
    Get.lazyPut(
            () => GenreMovieController(genreMovieRepository: Get.find<GenreMovieRepository>()),
        fenix: true);
  }
}