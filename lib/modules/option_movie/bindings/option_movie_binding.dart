
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/modules/option_movie/controller/option_movie_controller.dart';
import 'package:mobi_phim/modules/option_movie/provider/option_movie_provider.dart';
import 'package:mobi_phim/modules/option_movie/repository/option_movie_repository.dart';

import 'package:mobi_phim/services/http_provider.dart';


class OptionMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OptionMovieProvider(http: HttpProvider(httpClient: Dio())));
    Get.lazyPut(() => OptionMovieRepository(optionMovieProvider: Get.find<OptionMovieProvider>()),
        fenix: true);
    Get.lazyPut(
            () => OptionMovieController(optionMovieRepository: Get.find<OptionMovieRepository>()),
        fenix: true);
  }
}