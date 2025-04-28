import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_colors.dart';
import 'package:mobi_phim/modules/login/controller/login_controller.dart';
import 'package:mobi_phim/widgets/animation_text_loading.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.DEFAULT_BACKGROUND_COLORS,
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Đăng Nhập',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: context.width,
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 70,
                                width: controller.loginSuccess.value==true? 300 : 325,
                                child: controller.isLoadingUser.value==true ?
                                LoadingTextAnimation()
                                    :
                                TextFormField(
                                  controller: controller.usernameController,
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    fillColor: Colors.grey,
                                    filled: true,
                                    counterText: "",
                                    isDense: true,
                                    // errorStyle: TextStyle(color: Colors.white),
                                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                                    contentPadding: EdgeInsets.all(20),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(14)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green),
                                        borderRadius: BorderRadius.circular(14)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(14)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(14)),
                                  ),
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                  onChanged: (value) => controller.onTextFormUsernameChange(value),
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                              SizedBox(
                                height: 70,
                                width: controller.loginSuccess.value==true? 300 : 325,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    suffixIcon: GestureDetector(
                                     onTap: () => controller.isPasswordHidden.value= !controller.isPasswordHidden.value,
                                     child: controller.isPasswordHidden.value==true ? const Icon(Icons.visibility_off,size: 25,) : const Icon(Icons.visibility,size: 25,)),
                                    fillColor: Colors.grey,
                                    filled: true,
                                    counterText: "",
                                    isDense: true,
                                    // errorStyle: TextStyle(color: Colors.white),
                                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                                    contentPadding: EdgeInsets.all(20),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(14)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green),
                                        borderRadius: BorderRadius.circular(14)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(14)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(14)),
                                  ),
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                  obscureText: controller.isPasswordHidden.value,
                                  onChanged: (value) => controller.onTextFormPasswordChange(value),
                                ),
                              ),
                            ],
                          ),
                        ),
                        controller.loginSuccess.value==false ?
                        SizedBox()
                            :
                        FadeInRight(
                          duration: const Duration(milliseconds: 500),
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              controller.isLoadingLogin.value==false ?
                              IconButton(
                                  onPressed: controller.onLoginButtonPress,
                                  splashColor: Colors.white,
                                  icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                      size: 30
                                  )
                              )
                                :
                              Transform.scale(
                                scale: 0.7,
                                child: CircularProgressIndicator(strokeWidth: 4,color: Colors.white,),
                              ),
                            ],
                          ),
                        ),

                      ],
                    );
                  },)
                ),


                SizedBox(height: 15,),
                SizedBox(
                  width: context.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                          onPressed: () => controller.onloginWithGoogle(),
                          icon: Image.asset('assets/icon/google.png')
                        ),
                      ),
                      SizedBox(width: 15,),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                            onPressed: controller.onloginWithFacebook,
                            icon: Image.asset('assets/icon/facebook.png')
                        ),
                      ),
                      SizedBox(width: 15,),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                            onPressed: () => controller.onloginWithFigure(context),
                            icon: Image.asset('assets/icon/fingerprint.png')
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                SizedBox(
                  width: context.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Chưa có tài khoản? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.showRegisterDialog(context),
                        child: Text(
                          'Đăng ký ngay',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}


