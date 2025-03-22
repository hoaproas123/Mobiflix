
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/models/episodes_movie.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/modules/detail_movie/controller/detail_controller.dart';
import 'package:mobi_phim/widgets/widgets.dart';

class BuildDetailContentMovie extends StatelessWidget {
  const BuildDetailContentMovie({
    super.key,
    required this.detailMovie,
    required this.listEpisodes,
    required this.controller,
  });

  final ItemMovieModel? detailMovie;
  final List<EpisodesMovieModel>? listEpisodes;
  final DetailController controller;


  @override
  Widget build(BuildContext context) {
    Size screenSize= MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => controller.onPlayButtonPress(),
                style: ButtonStyle(
                    minimumSize: const WidgetStatePropertyAll(Size(40, 15)),
                    backgroundColor: const WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))

                ),
                child: Container(
                  alignment: Alignment.center,
                  width: context.width*2/5,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_arrow,color: Colors.black,size: screenSize.width*0.07,),
                      Text(AppString.PLAY_BUTTON,style: TextStyle(fontSize: screenSize.width*0.05,color: Colors.black),)
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () => controller.onFavoriteButtonPress(),
                style: ButtonStyle(
                    minimumSize: const WidgetStatePropertyAll(Size(40, 15)),
                    backgroundColor: const WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))

                ),
                child: Container(
                  alignment: Alignment.center,
                  width: context.width*2/5,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() => Icon(
                        controller.isFavorite.value ==true ? Icons.favorite_outlined : Icons.favorite_outline,
                        color: controller.isFavorite.value ==true ? Colors.red : Colors.black,
                        size: screenSize.width*0.07,
                      ),
                      ),
                      SizedBox(width: 5,),
                      Text(AppString.FAVORITE_BUTTON,style: TextStyle(fontSize: screenSize.width*0.05,color: Colors.black),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Html(
          data: detailMovie?.content?? DefaultString.NULL,
          style: {
            "body": Style(
              color: Colors.white,      // Đổi màu chữ thành trắng
              fontSize: FontSize(screenSize.width*0.04), // Đổi kích thước chữ thành 15
            ),
          },
        ),
        Container(
          padding: WidgetSize.paddingPageAll_8,
          width: context.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${MovieString.GENRE_TITLE} : ${(detailMovie?.list_category??[]).map((item) => item.name).join(", ")}" ,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: screenSize.width*0.03,
                ),
              ),
              Text(
                "${MovieString.ACTORS_TITLE}: ${(detailMovie?.actor??[]).map((item) => item).join(", ")}" ,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: screenSize.width*0.03,
                ),
              ),
              Text(
                "${MovieString.DIRECTOR_TITLE}: ${(detailMovie?.director??[]).map((item) => item).join(", ")}" ,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: screenSize.width*0.03,
                ),
              ),
              Text(
                "${MovieString.COUNTRY_TITLE}: ${(detailMovie?.list_country??[]).map((item) => item.name).join(", ")}",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: screenSize.width*0.03,
                ),
              ),
              Text(
                '${MovieString.DURATION_TITLE}: ${detailMovie?.time ?? DefaultString.NULL}',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: screenSize.width*0.03
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
