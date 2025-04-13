
import 'package:flutter/material.dart';
import 'package:mobi_phim/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: controller.currentAppbar
            ),
            body: controller.currentPage,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: (value) => controller.changePage(value),
              backgroundColor: Colors.black,
              iconSize: 35,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey.shade800,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Trang chủ'),
                BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Người dùng'),
              ],
            ),
          );
        },),
        Obx(() {
          if (controller.isLoading.value==true) {
            return FadeTransition(
                opacity: controller.fadeAnimation,
                child: Center(child: const CircularProgressIndicator(color: Colors.white,)));
          } else {
            return const SizedBox();
          }
        },)

      ],
    );
  }
}




