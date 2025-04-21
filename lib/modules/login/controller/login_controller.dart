
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobi_phim/core/alert.dart';
import 'package:mobi_phim/models/user_account_model.dart';
import 'package:mobi_phim/models/user_model.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:mobi_phim/services/db_mongo_service.dart';


class LoginController extends GetxController {
  RxBool loginSuccess=false.obs;
  UserModel? userData;
  String username='';
  String password='';
  RxBool isPasswordHidden=true.obs;
  bool isAccountExist=false;
  RxBool isLoadingAccount=false.obs;
  Timer? _debounce;


  final username_FieldKey = GlobalKey<FormFieldState>();
  final password_FieldKey = GlobalKey<FormFieldState>();
  final againPassword_FieldKey = GlobalKey<FormFieldState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // clientId: '653861227963-1ke10hqdveto2t2sj7jv34mkr5th006g.apps.googleusercontent.com',
    scopes: [
      'email',
      'profile',
    ],
  );
  bool canLogin=false;
  @override
  Future<void> onInit() async {
    super.onInit();
  }
  Future<void> checkInternetConnection() async {
    canLogin=false;
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      await Alert.showConfirm(
          title: 'Cảnh báo',
          message: 'Bạn đang sử dụng 4G, hành động này có thể gây tiêu tốn dữ liệu',
          buttonTextOK: 'Tiếp tục',
          buttonTextNO: 'Hủy',
          onPressedOK: (){
            canLogin=true;
            Get.back();
          }
      );
    } else if (connectivityResult == ConnectivityResult.none) {
      Alert.showError(
          title: 'Lỗi',
          message: 'Hiện không có kết nối mạng, vui lòng kiểm tra lại đường truyền',
          buttonText: 'Đóng');
    }
    else{canLogin=true;}
  }
  onTextFormUsernameChange(value) {
    username=value;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (username!='') {
        loginSuccess.value=await DbMongoService().getUser(username, password);
      }
    });
  }
  onTextFormPasswordChange(value) {
    password=value;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (password!='') {
        loginSuccess.value=await DbMongoService().getUser(username, password);

      }
    });

  }
  onLoginButtonPress() async {
    await checkInternetConnection();
    if(canLogin==true){
      userData = UserModel(username: username,name: username);
      Get.offAndToNamed(Routes.HOME,arguments: userData);
      Get.snackbar(
          'Đăng Nhập thành công',
          'Xin chào ${userData?.name}',
          colorText: Colors.white
      );
    }
  }
  Future<void> onloginWithFacebook() async {
    await checkInternetConnection();
    if(canLogin==true){
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final _userData = await FacebookAuth.instance.getUserData();
        userData = UserModel.fromJson(_userData);
        Get.offAndToNamed(Routes.HOME,arguments: userData);
        Get.snackbar(
            'Đăng Nhập thành công',
            'Xin chào ${userData?.name}',
            colorText: Colors.white
        );

      } else {
        print("Facebook login failed: ${result.status}");
      }
    }
  }
  Future<void> onLogoutFacebook() async {
    await FacebookAuth.instance.logOut();
  }
  Future<void> onloginWithGoogle() async {
    await checkInternetConnection();
    if(canLogin==true){
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
        Get.snackbar(
            'Đăng Nhập thành công',
            'Xin chào ${userData?.name}',
          colorText: Colors.white
        );
      } catch (error) {
        print('Lỗi đăng nhập Google: $error');
      }
    }
  }
  Future<void> onLogoutGoogle() async {
    await _googleSignIn.signOut();
  }


  Future<void> onloginWithFigure(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Đăng nhập bằng vân tay'),
          titleTextStyle: TextStyle(fontSize: 18,color: Colors.white),
          backgroundColor: Colors.grey,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.fingerprint_sharp,color: Colors.white,size: 60,),
                SizedBox(height: 15,),
                Text('Chạm vào cảm biến vân tay',style: TextStyle(color: Colors.white,fontSize: 15),),
              ],
            ),
          ),
        );
      },
    );
  }
  Future<void> logout() async {
    onLogoutFacebook();
    onLogoutGoogle();
    userData = null;
    canLogin=false;
    Get.offAndToNamed(Routes.LOGIN);
  }

  void showRegisterDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Đăng ký'),
          content: SizedBox(
            width: context.width*0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return TextFormField(
                      key: username_FieldKey,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: 'Tài khoản',
                          counterText: "",
                          isDense: true,
                          // errorStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                          contentPadding: EdgeInsets.all(20),
                          suffixIcon: isLoadingAccount.value==true ? Transform.scale(
                            scale: 0.5,
                            child: CircularProgressIndicator(strokeWidth: 4,),) : null
                      ) ,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      validator: (value)  {
                        if (value != null && isAccountExist==true) {
                          return 'Tên đăng nhập đã  tồn tại';
                        }
                        else if(value==null||value==''){
                          return 'Tài khoản không được để trống';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) _debounce!.cancel();
                        _debounce = Timer(const Duration(milliseconds: 1000), () async {
                          if (value!='') {
                            isLoadingAccount.value=true;
                            isAccountExist=await DbMongoService().isExistUser(value);
                            isLoadingAccount.value=false;
                          }
                        });
                      },
                      onEditingComplete: () {
                        if(isLoadingAccount.value==false){
                          if (username_FieldKey.currentState!.validate()) {
                            // Xử lý nếu input hợp lệ
                            FocusScope.of(context).nextFocus();
                          }
                        }
                      },
                    );
                  },),
                  Obx(() {
                    return Column(
                      children: [
                        TextFormField(
                          key: password_FieldKey,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Mật khẩu',
                            counterText: "",
                            isDense: true,
                            // errorStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                            contentPadding: EdgeInsets.all(20),
                            suffixIcon: GestureDetector(
                                onTap: () => isPasswordHidden.value= !isPasswordHidden.value,
                                child: isPasswordHidden.value==true ? const Icon(Icons.visibility_off,size: 25,) : const Icon(Icons.visibility,size: 25,)),
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          obscureText: isPasswordHidden.value,
                          validator: (value)  {
                            if(value==null||value==''){
                              return 'Nhập mật khẩu';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            if(isLoadingAccount.value==false){
                              if (password_FieldKey.currentState!.validate()) {
                                // Xử lý nếu input hợp lệ
                                FocusScope.of(context).nextFocus();
                              }
                            }
                          },

                        ),
                        TextFormField(
                          key: againPassword_FieldKey,
                          decoration: InputDecoration(
                            hintText: 'Nhập lại mật khẩu',
                            counterText: "",
                            isDense: true,
                            // errorStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                            contentPadding: EdgeInsets.all(20),
                            suffixIcon: GestureDetector(
                                onTap: () => isPasswordHidden.value= !isPasswordHidden.value,
                                child: isPasswordHidden.value==true ? const Icon(Icons.visibility_off,size: 25,) : const Icon(Icons.visibility,size: 25,)),
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          obscureText: isPasswordHidden.value,
                          validator: (value)  {
                            if(value==null||value==''){
                              return 'Nhập lại mật khẩu';
                            }
                            else if(value!= null && value!=password_FieldKey.currentState!.value){
                              return 'Mật khẩu không trùng khớp';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            if (againPassword_FieldKey.currentState!.validate()) {
                              // Xử lý nếu input hợp lệ
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      ],
                    );
                  },),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                FocusScope.of(context).unfocus();
              },
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                // xử lý đăng ký
                if(username_FieldKey.currentState!.validate()&&password_FieldKey.currentState!.validate()&&againPassword_FieldKey.currentState!.validate()){
                  DbMongoService().addUser(
                      UserAccountModel(
                        username: username_FieldKey.currentState!.value,
                        password: againPassword_FieldKey.currentState!.value
                      ),
                  );
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                  Get.snackbar(
                      'Đăng Ký thành công',
                      'Bắt đầu đăng nhập',
                      colorText: Colors.white
                  );
                }

              },
              child: Text('Đăng ký'),
            ),
          ],
        );
      },
    );
  }
}