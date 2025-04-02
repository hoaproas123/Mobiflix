
import 'package:flutter/material.dart';
import 'package:mobi_phim/constant/app_colors.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/models/movies_model.dart';
import 'package:mobi_phim/modules/home/widgets/optionsBar_widget.dart';
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
              backgroundColor: controller.backgroundColor.value,
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
                  onPressed: () => controller.onSearchPress(),
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
                      colors: controller.backgroundColor.value==AppColors.DEFAULT_APPBAR_COLOR ?
                      AppColors.DEFAULT_BACKGROUND_COLORS
                          :
                      AppColors.LINEAR_BACKGROUND_COLORS(controller.hsl.value),
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                    ),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async{
                      Future.delayed(const Duration(milliseconds: 300),() {
                        controller.onLoading();
                      },);
                    },
                    child: ListView(
                        controller: controller.scrollController,
                        scrollDirection: Axis.vertical,
                        children: [
                          context.orientation==Orientation.portrait ?
                          Column(
                            children: [
                              WidgetSize.sizedBoxHeight_15,
                              OptionsBarWidget(controller: controller),
                              HighlightMovieWidget(controller: controller,),
                              WidgetSize.sizedBoxHeight_15,
                              ListMovieWidget(title: MovieString.LIST_CONTINUE_MOVIE_WATCH_TITLE,controller: controller,listType: ListType.CONTINUE_MOVIE_WATCH,),
                              ListMovieWidget(title: MovieString.NEW_UPDATE_TITLE,controller: controller,listType: ListType.NEW_UPDATE_MOVIE,),
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
                            ],
                          )
                              :
                          SizedBox(
                            height: context.height*0.8,
                            child: PageView(
                              scrollDirection: Axis.vertical,
                              onPageChanged: (value) {
                                if(value==3) {
                                  controller.accessScroll.value= !controller.accessScroll.value;
                                }
                              },
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WidgetSize.sizedBoxHeight_5,
                                    OptionsBarWidget(controller: controller),
                                    HighlightMovieWidget(controller: controller,),
                                  ],
                                ),
                                ListMovieWidget(title: MovieString.LIST_CONTINUE_MOVIE_WATCH_TITLE,controller: controller,listType: ListType.CONTINUE_MOVIE_WATCH,),
                                ListMovieWidget(title: MovieString.NEW_UPDATE_TITLE,controller: controller,listType: ListType.NEW_UPDATE_MOVIE,),
                                SizedBox(
                                  height: context.height*0.8,
                                  child: PageView.builder(
                                    onPageChanged: (value) {
                                      if(value==0) {
                                        controller.accessScroll.value= !controller.accessScroll.value;
                                      }
                                    },
                                    physics: controller.accessScroll.value ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.listMovieModel.length,
                                    itemBuilder: (context, index) {
                                      MoviesModel moviesModel=controller.listMovieModel[index];
                                      int? len=moviesModel.pagination?.totalPages;
                                      return len == 0 ? const SizedBox() : ListMovieWidget(title: (moviesModel.titlePage)??DefaultString.NULL,index: index,controller: controller,);
                                    },),
                                ),
                              ],
                            ),
                          ),
                        ]
                    ),
                  )
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




