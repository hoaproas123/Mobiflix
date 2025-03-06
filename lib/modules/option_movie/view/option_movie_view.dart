import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_colors.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/data/country_data.dart';
import 'package:mobi_phim/data/option_view_data.dart';
import 'package:mobi_phim/models/movies_model.dart';
import 'package:mobi_phim/modules/option_movie/controller/option_movie_controller.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:mobi_phim/widgets/highlight_movie_widget.dart';
import 'package:mobi_phim/widgets/list_movie_widget.dart';
import 'package:mobi_phim/widgets/widgets.dart';


class OptionMovieView extends GetView<OptionMovieController> {
  const OptionMovieView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() => AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: controller.backgroundColor.value == Colors.white ?  AppColors.DEFAULT_APPBAR_COLOR :controller.backgroundColor.value,
          elevation: 0,
          title: Text(
            controller.tag,
            style: const TextStyle(
                color: Colors.white
            ),
          ),
          actions: [
            IconButton(
              onPressed: (){
                String addYearQuery=controller.selectYear.value==DefaultString.YEAR ? DefaultString.NULL:'&year=${controller.selectYear.value}';
                String addCountryQuery=controller.selectCountry.value.slug==DefaultString.COUNTRY ? DefaultString.NULL : '&country=${controller.selectCountry.value.slug}';
                String addQuery= addYearQuery + addCountryQuery;
                Get.toNamed(Routes.SEARCH_MOVIE,arguments: [controller.backgroundColor.value,controller.hsl.value,addQuery]);
              },
              icon: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
            WidgetSize.sizedBoxWidth_10
          ],
        ),),
      ),

      body: Obx(() {
        return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: controller.backgroundColor.value == Colors.white ?
                AppColors.DEFAULT_BACKGROUND_COLORS
                    :
                List.generate(6, (index) {
                  double lightness = controller.hsl.value.lightness * (1 - (index * 0.17)); // Giảm 15% mỗi bước
                  return controller.hsl.value.withLightness(lightness.clamp(0.0, 1.0)).toColor();
                }),
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
            child: Builder(
                builder: (context) {
                  return ListView(
                      children: [
                        WidgetSize.sizedBoxHeight_15,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:  8.0),
                          child: SizedBox(
                            height: 30,
                            child: Row(
                              children: [
                                Hero(
                                  tag: TagString.CLOSE,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                          side: const BorderSide(color: Colors.white, width: 1),
                                          minimumSize: const Size(30, 30),
                                        ),
                                        onPressed: (){
                                          Get.back();
                                        },
                                        child: const Icon(Icons.close,color: Colors.white,size: 15,)),
                                  ),
                                ),
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Hero(
                                      tag: controller.tag,
                                      child: TextButton(
                                        onPressed: (){},
                                        style:  ButtonStyle(
                                            side: const WidgetStatePropertyAll(BorderSide(color: Colors.white, width: 1)),
                                            // minimumSize: const WidgetStatePropertyAll(Size(40, 15)),
                                            backgroundColor: WidgetStatePropertyAll(Colors.grey.withOpacity(0.4))
                                        ),
                                        child: Text(
                                          controller.title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                controller.tag==DefaultString.YEAR ? const SizedBox() :
                                SizedBox(
                                  child: Obx(() {
                                    return Hero(
                                      tag: listOption[4].optionName.toString(),
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
                                              maxWidth: 100, // Chiều rộng tối đa
                                              maxHeight: 300,
                                            ),
                                            offset: const Offset(-30,0),
                                            position: PopupMenuPosition.over,
                                            color: Colors.transparent.withOpacity(0.8),

                                            onSelected: (int result) {
                                              controller.onSelectYear(result);
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
                                controller.tag ==DefaultString.COUNTRY ? const SizedBox() :
                                SizedBox(
                                  child: Obx(() {
                                    return Hero(
                                      tag: listOption[5].optionName.toString(),
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
                                              controller.onSelectCountry(result);
                                            },
                                            itemBuilder: (context) {
                                              return List.generate(countryList.length, (index) {
                                                return PopupMenuItem<int>(
                                                  value: index,
                                                  child: Text(countryList[index].name!,style: const TextStyle(color: Colors.white),),
                                                );
                                              });
                                            },
                                            child: Text(
                                              controller.selectCountry.value.name!,
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
                              ],
                            ),
                          ),
                        ),
                        HighlightMovieWidget(controller: controller,url: false,),
                        GetBuilder<OptionMovieController>(builder: (controller) {
                          return Column(
                            children: [
                              controller.tag ==DefaultString.YEAR || controller.selectYear.value!=DefaultString.YEAR || controller.selectCountry.value.name!=DefaultString.COUNTRY ? const SizedBox() :
                              controller.tag ==DefaultString.COUNTRY ? ListMovieWidget(title: MovieString.NEW_UPDATE_TITLE_COUNTRY(controller.title),controller: controller,url: false,isHome:false) :
                              ListMovieWidget(title: MovieString.NEW_UPDATE_TITLE_OPTION(controller.tag),controller: controller,url: false,isHome: false,),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.listMovieModel.length,
                                itemBuilder: (context, index) {
                                  MoviesModel moviesModel=controller.listMovieModel[index];
                                  int? len=moviesModel.pagination?.totalPages;
                                  return len == 0 ? const SizedBox() : ListMovieWidget(title: (moviesModel.title)??DefaultString.NULL,index: index,controller: controller,isHome: false,);
                                },),
                            ],
                          );
                        },)
                      ]
                  );
                }
            )
        );
      },)
    );
  }
}