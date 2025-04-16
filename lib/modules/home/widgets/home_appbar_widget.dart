
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/modules/home/controller/home_controller.dart';
class HomeAppbarWidget extends GetView<HomeController> {
  HomeAppbarWidget({
    this.title=AppString.APP_NAME,
    this.actions,
    super.key,
  });
  String title;
  List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppBar(
        leading: context.orientation==Orientation.portrait ?
        null
            :
        IconButton(
          icon: Icon(Icons.menu,color: Colors.white,),
          onPressed: () {
            controller.scaffoldKey.currentState!.openDrawer();
          },),
        automaticallyImplyLeading: false,
        backgroundColor: title==AppString.APP_NAME ? controller.backgroundColor.value : Colors.black,
        elevation: 0,
        title: GestureDetector(
          onTap: title==AppString.APP_NAME ? controller.scrollToTop : null,
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white
            ),
          ),
        ),
        actions: actions,
      );
    },);
  }
}

