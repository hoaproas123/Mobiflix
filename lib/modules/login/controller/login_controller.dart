
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobi_phim/models/user_model.dart';
import 'package:mobi_phim/routes/app_pages.dart';


class LoginController extends GetxController {
  RxBool loginSuccess=false.obs;
  UserModel? userData;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // clientId: '653861227963-1ke10hqdveto2t2sj7jv34mkr5th006g.apps.googleusercontent.com',
    scopes: [
      'email',
      'profile',
    ],
  );
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
        Get.offAndToNamed(Routes.HOME,arguments: userData);


    } else {
      print("Facebook login failed: ${result.status}");
    }
  }
  Future<void> onLogoutFacebook() async {
    await FacebookAuth.instance.logOut();
  }
  Future<void> onloginWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        print('Người dùng đã huỷ đăng nhập');
        return;
      }
      userData = UserModel(
        id: account.id,
        name: account.displayName,
        urlAvatar: account.photoUrl
      );
      Get.offAndToNamed(Routes.HOME,arguments: userData);
    } catch (error) {
      print('Lỗi đăng nhập Google: $error');
    }
  }
  Future<void> onLogoutGoogle() async {
    await _googleSignIn.signOut();
  }


  Future<void> onloginWithFigure() async {
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
    onLogoutFacebook();
    onLogoutGoogle();
    userData = null;
    Get.offAndToNamed(Routes.LOGIN);
  }
}