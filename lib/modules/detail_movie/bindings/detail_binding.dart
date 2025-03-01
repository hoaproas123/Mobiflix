
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/modules/detail_movie/controller/detail_controller.dart';
import 'package:mobi_phim/modules/detail_movie/provider/detail_provider.dart';
import 'package:mobi_phim/modules/detail_movie/repository/detail_repository.dart';

import 'package:mobi_phim/services/http_provider.dart';


class DetailBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => DetailProvider(http: HttpProvider(httpClient: Dio())));
    Get.lazyPut(() => DetailRepository(detailProvider: Get.find<DetailProvider>()),
        fenix: true);
    Get.lazyPut(
            () => DetailController(detailRepository: Get.find<DetailRepository>()),
        fenix: true);
  }
}