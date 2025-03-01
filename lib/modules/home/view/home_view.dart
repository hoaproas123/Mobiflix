import 'package:flutter/material.dart';
import 'package:mobi_phim/constant/app_colors.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/models/movies_model.dart';
import 'package:mobi_phim/modules/splash/view/splash_screen.dart';
import 'package:mobi_phim/widgets/highlight_movie_widget.dart';
import 'package:mobi_phim/widgets/list_movie_widget.dart';
import 'package:mobi_phim/widgets/widgets.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: controller.backgroundColor.value == Colors.white ?  AppColors.DEFAULT_APPBAR_COLOR : controller.backgroundColor.value,
              elevation: 0,
              title: GestureDetector(
                onTap: controller.scrollToTop,
                child: const Text(
                  AppString.APP_NAME,
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: (){
                    String addQuery=DefaultString.NULL;
                    Get.toNamed('/home/search',arguments: [controller.backgroundColor.value,controller.hsl.value,addQuery]);
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                WidgetSize.sizedBoxWidth_10
              ],
            ),
            body: Center(
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: controller.backgroundColor.value == Colors.white ?
                      AppColors.DEFAULT_BACKGROUND_COLORS
                          :
                      List.generate(AppNumber.DEFAULT_NUMBER_OF_COLOR, (index) {
                        double lightness = controller.hsl.value.lightness * (1 - (index * 0.17)); // Giảm 15% mỗi bước
                        return controller.hsl.value.withLightness(lightness.clamp(0.0, 1.0)).toColor();
                      }),
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                    ),
                  ),
                  child: Builder(builder: (context) {
                    return ListView(
                        controller: controller.scrollController,
                        children: [
                          WidgetSize.sizedBoxHeight_15,
                          SizedBox(
                            height: 30,
                            child: Row(
                                children: [
                                  const SizedBox(
                                    child: Hero(tag: TagString.CLOSE, child: SizedBox()),
                                  ),
                                ] + List.generate(controller.listOptionView.length, (index) {
                                  return controller.listOptionView[index].type=='TextButton' ?
                                  SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 5.0),
                                      child: Hero(
                                        tag: controller.listOptionView[index].optionName.toString(),
                                        child: TextButton(
                                          onPressed: (){
                                            Get.toNamed(
                                                'home/optionMovie',
                                                arguments: [
                                                  controller.listOptionView[index].optionName.toString(),
                                                  controller.listOptionView[index].optionName.toString(),
                                                  controller.listOptionView[index].url
                                                ]
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                              side: const BorderSide(color: Colors.white, width: 1),
                                              minimumSize: const Size(40, 15)
                                          ),
                                          child: Text(
                                            controller.listOptionView[index].optionName.toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                      :
                                  const SizedBox();
                                },)
                                    +[
                                      SizedBox(
                                          child: Obx(() {
                                            return Hero(
                                              tag: controller.listOptionView[4].optionName.toString(),
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent, // Nền trong suốt
                                                  borderRadius: BorderRadius.circular(15), // Bo tròn góc
                                                  border: Border.all(
                                                    color: Colors.white, // Viền màu trắng
                                                    width: 1, // Độ dày của viền
                                                  ),
                                                ),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: PopupMenuButton<int>(
                                                    constraints: const BoxConstraints(
                                                      maxWidth: 100, // Chiều rộng tối đa
                                                      maxHeight: 300,
                                                    ),
                                                    offset: const Offset(-30,0),
                                                    position: PopupMenuPosition.over,
                                                    color: Colors.transparent.withOpacity(0.8),

                                                    onSelected: (int result) {
                                                      controller.onSelectYear(result,controller.listOptionView[4].optionName.toString());
                                                    },
                                                    itemBuilder: (context) {
                                                      return List.generate(controller.listYear.length, (index) {
                                                        return PopupMenuItem<int>(
                                                          value: index,
                                                          child: Text(controller.listYear[index].toString(),style: const TextStyle(color: Colors.white),),
                                                        );
                                                      });
                                                    },
                                                    child: Text(
                                                      controller.selectYear.value,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },)
                                      ),
                                      WidgetSize.sizedBoxWidth_5,
                                      SizedBox(
                                          child: Obx(() {
                                            return Hero(
                                              tag: controller.listOptionView[5].optionName.toString(),
                                              child: Container(
                                                padding: const EdgeInsets.all(7),
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent, // Nền trong suốt
                                                  borderRadius: BorderRadius.circular(15), // Bo tròn góc
                                                  border: Border.all(
                                                    color: Colors.white, // Viền màu trắng
                                                    width: 1, // Độ dày của viền
                                                  ),
                                                ),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: PopupMenuButton<int>(
                                                    constraints: const BoxConstraints(
                                                      maxWidth: 150, // Chiều rộng tối đa
                                                      maxHeight: 300,
                                                    ),
                                                    offset: const Offset(-50,0),
                                                    position: PopupMenuPosition.over,
                                                    color: Colors.transparent.withOpacity(0.8),
                                                    onSelected: (int result) {
                                                      controller.onSelectCountry(result,controller.listOptionView[5].optionName.toString());
                                                    },
                                                    itemBuilder: (context) {
                                                      return List.generate(controller.listCountry.length, (index) {
                                                        return PopupMenuItem<int>(
                                                          value: index,
                                                          child: Text(controller.listCountry[index].name!,style: const TextStyle(color: Colors.white),),
                                                        );
                                                      });
                                                    },
                                                    child: Text(
                                                      controller.selectCountry.value,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },)
                                      ),
                                    ]
                            ),
                          ),
                          HighlightMovieWidget(controller: controller,),
                          ListMovieWidget(title: MovieString.NEW_UPDATE_TITLE,controller: controller,),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            cacheExtent: 10,
                            itemCount: controller.listMovieModel.length,
                            itemBuilder: (context, index) {
                              MoviesModel moviesModel=controller.listMovieModel[index];
                              int? len=moviesModel.pagination?.totalPages;
                              return len == 0 ? const SizedBox() : ListMovieWidget(title: (moviesModel.titlePage)??DefaultString.NULL,index: index,controller: controller,);
                            },),
                        ]
                    );
                  },)
              ),
            ),
          );
        },),
        Obx(() {
          if (controller.isSplash.value==true) {
            return FadeTransition(opacity: controller.fadeAnimation, child: const SplashScreen());
          } else {
            return const SizedBox();
          }
        },)

      ],
    );
  }
}




