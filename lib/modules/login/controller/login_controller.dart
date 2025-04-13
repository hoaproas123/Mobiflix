
import 'package:flutter/animation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/models/user_model.dart';
import 'package:mobi_phim/routes/app_pages.dart';


class LoginController extends GetxController {
  RxBool loginSuccess=false.obs;
  UserModel? userData;
  @override
  Future<void> onInit() async {
    super.onInit();

  }
  onLoginButtonPress(){
    Get.offAndToNamed(Routes.HOME);
  }
  Future<void> onloginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final _userData = await FacebookAuth.instance.getUserData();
        userData = UserModel.fromJson(_userData);
        print(userData?.urlAvatar);
        Get.offAndToNamed(Routes.HOME,arguments: userData);


    } else {
      print("Facebook login failed: ${result.status}");
    }
  }
  Future<void> logout() async {
    await FacebookAuth.instance.logOut();
      userData = null;
    Get.offAndToNamed(Routes.LOGIN);
  }
}