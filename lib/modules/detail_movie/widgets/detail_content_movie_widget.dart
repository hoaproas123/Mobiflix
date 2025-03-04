
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/models/episodes_movie.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/modules/detail_movie/controller/detail_controller.dart';
import 'package:mobi_phim/routes/app_pages.dart';

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () async {
              List inforSave=await controller.getSavedEpisode(controller.slug);
              int server = int.parse(inforSave[0]);
              int episode = int.parse(inforSave[1]);
              controller.saveEpisode(server,episode+1);
              Get.toNamed(Routes.PLAY_MOVIE, arguments: [server,episode+1, controller.slug, listEpisodes]);
            },
            style: ButtonStyle(
                minimumSize: const WidgetStatePropertyAll(Size(40, 15)),
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))

            ),
            child: Container(
              alignment: Alignment.center,
              width: context.width,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.play_arrow,color: Colors.black,size: 30,),
                  Text(AppString.PLAY_BUTTON,style: TextStyle(fontSize: 20,color: Colors.black),)
                ],
              ),
            ),
          ),
        ),
        Html(
          data: detailMovie?.content?? DefaultString.NULL,
          style: {
            "body": Style(
              color: Colors.white,      // Đổi màu chữ thành trắng
              fontSize: FontSize(15.0), // Đổi kích thước chữ thành 15
            ),
          },
        ),
        Container(
          padding: const EdgeInsets.all(8),
          width: context.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${MovieString.GENRE_TITLE} : ${(detailMovie?.list_category??[]).map((item) => item.name).join(", ")}" ,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
              Text(
                "${MovieString.ACTORS_TITLE}: ${(detailMovie?.actor??[]).map((item) => item).join(", ")}" ,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
              Text(
                "${MovieString.DIRECTOR_TITLE}: ${(detailMovie?.director??[]).map((item) => item).join(", ")}" ,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
              Text(
                "${MovieString.COUNTRY_TITLE}: ${(detailMovie?.list_country??[]).map((item) => item.name).join(", ")}",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
              Text(
                '${MovieString.DURATION_TITLE}: ${detailMovie?.time ?? DefaultString.NULL}',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
