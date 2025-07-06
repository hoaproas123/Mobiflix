
import 'package:get/get.dart';
import 'package:mobi_phim/controller/auth_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}