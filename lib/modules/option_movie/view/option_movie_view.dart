import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_colors.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/models/movies_model.dart';
import 'package:mobi_phim/modules/option_movie/controller/option_movie_controller.dart';
import 'package:mobi_phim/modules/option_movie/widgets/optionsBar_widget.dart';
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
          backgroundColor: controller.backgroundColor.value,
          elevation: 0,
          title: Text(
            controller.tag,
            style: const TextStyle(
                color: Colors.white
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
        ),),
      ),

      body: Obx(() {
        return Container(
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
            child: ListView(
                children: [
                  context.orientation==Orientation.portrait ?
                  Column(
                    children: [
                      WidgetSize.sizedBoxHeight_15,
                      OptionsBarWidget(controller: controller),
                      HighlightMovieWidget(controller: controller,url: false,),
                      WidgetSize.sizedBoxHeight_15,
                      controller.tag ==DefaultString.YEAR || controller.selectYear.value!=DefaultString.YEAR || controller.selectCountry.value.name!=DefaultString.COUNTRY ?
                      const SizedBox()
                          :
                      controller.tag ==DefaultString.COUNTRY ?
                      ListMovieWidget(title: MovieString.NEW_UPDATE_TITLE_COUNTRY(controller.title),controller: controller,url: false,isHome:false,listType: ListType.NEW_UPDATE_MOVIE,)
                          :
                      ListMovieWidget(title: MovieString.NEW_UPDATE_TITLE_OPTION(controller.tag),controller: controller,url: false,isHome: false,listType: ListType.NEW_UPDATE_MOVIE,),
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
                  )
                      :
                  SizedBox(
                    height: context.height*0.8,
                    child: PageView(
                      scrollDirection: Axis.vertical,
                      onPageChanged: (value) {
                        if(value==1) {
                          controller.accessScroll.value= !controller.accessScroll.value;
                        }
                      },
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WidgetSize.sizedBoxHeight_5,
                            OptionsBarWidget(controller: controller),
                            HighlightMovieWidget(controller: controller,url: false,),
                          ],
                        ),
                        if((controller.tag ==DefaultString.COUNTRY && (controller.tag !=DefaultString.YEAR || controller.selectYear.value==DefaultString.YEAR || controller.selectCountry.value.name==DefaultString.COUNTRY))==true)
                          ListMovieWidget(title: MovieString.NEW_UPDATE_TITLE_COUNTRY(controller.title),controller: controller,url: false,isHome:false,listType: ListType.NEW_UPDATE_MOVIE,)
                        else if(controller.tag !=DefaultString.COUNTRY && controller.tag !=DefaultString.YEAR && controller.selectYear.value==DefaultString.YEAR && controller.selectCountry.value.name==DefaultString.COUNTRY)
                          ListMovieWidget(title: MovieString.NEW_UPDATE_TITLE_OPTION(controller.tag),controller: controller,url: false,isHome: false,listType: ListType.NEW_UPDATE_MOVIE,),
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
                              return len == 0 ? const SizedBox() : ListMovieWidget(title: (moviesModel.title)??DefaultString.NULL,index: index,controller: controller,isHome: false,);
                            },),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
        );
      },)
    );
  }
}