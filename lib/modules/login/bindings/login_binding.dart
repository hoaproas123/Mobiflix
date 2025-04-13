
import 'package:get/get.dart';
import 'package:mobi_phim/modules/login/controller/login_controller.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => GenreMovieProvider(http: HttpProvider(httpClient: Dio())));
    // Get.lazyPut(() => GenreMovieRepository(genreMovieProvider: Get.find<GenreMovieProvider>()),
    //     fenix: true);
    Get.lazyPut(
            () => LoginController(),
        fenix: true);
  }
}