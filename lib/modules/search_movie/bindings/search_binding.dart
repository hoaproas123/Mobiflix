
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/modules/search_movie/controller/search_controller.dart';
import 'package:mobi_phim/modules/search_movie/provider/search_provider.dart';
import 'package:mobi_phim/modules/search_movie/repository/search_repository.dart';

import 'package:mobi_phim/services/http_provider.dart';


class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchProvider(http: HttpProvider(httpClient: Dio())));
    Get.lazyPut(() => SearchRepository(searchProvider: Get.find<SearchProvider>()),
        fenix: true);
    Get.lazyPut(
            () => SearchMovieController(searchRepository: Get.find<SearchRepository>()),
        fenix: true);
  }
}