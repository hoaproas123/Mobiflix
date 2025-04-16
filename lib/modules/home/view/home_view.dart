
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
            key: controller.scaffoldKey,
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: controller.backgroundColor.value,
                    ),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Trang chủ'),
                    onTap: () {
                      controller.currentIndex.value=0;
                      controller.changePage(controller.currentIndex.value);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Người dùng'),
                    onTap: () {
                      controller.currentIndex.value=1;
                      controller.changePage(controller.currentIndex.value);
                    },
                  ),
                ],
              ),
            ),
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: controller.currentAppbar
            ),
            body: controller.currentPage,
            bottomNavigationBar: context.orientation==Orientation.portrait ?
            BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: (value) => controller.changePage(value),
              backgroundColor: Colors.black,
              iconSize: 25,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey.shade800,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Trang chủ'),
                BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Người dùng'),
              ],
            )
              :
            null,
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




