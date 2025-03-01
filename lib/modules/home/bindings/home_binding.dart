
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/modules/home/controller/home_controller.dart';
import 'package:mobi_phim/modules/home/provider/home_provider.dart';
import 'package:mobi_phim/modules/home/repository/home_repository.dart';
import 'package:mobi_phim/services/http_provider.dart';


class HomeBinding extends Bindings {
  // @override
  //   HomeController dependencies() {
  //     return Get.put<HomeController>(HomeController());
  //   }
  @override
  void dependencies() {
    Get.lazyPut(() => HomeProvider(http: HttpProvider(httpClient: Dio())));
    Get.lazyPut(() => HomeRepository(homeProvider: Get.find<HomeProvider>()),
        fenix: true);
    Get.lazyPut(
            () => HomeController(homeRepository: Get.find<HomeRepository>()),
        fenix: true);
  }
}