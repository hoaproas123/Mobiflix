import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/modules/detail_movie/controller/detail_controller.dart';
import 'package:mobi_phim/modules/detail_movie/widgets/avatar_movie_widget.dart';
import 'package:mobi_phim/modules/detail_movie/widgets/content_movie_widget.dart';
import 'package:mobi_phim/modules/detail_movie/widgets/detail_content_movie_widget.dart';
import 'package:mobi_phim/modules/detail_movie/widgets/tap_option_movie_widget.dart';
import 'package:mobi_phim/widgets/loading_screen_widget.dart';
import 'package:mobi_phim/widgets/widgets.dart';

class DetailMovieView extends GetView<DetailController> {
  const DetailMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: controller.textColor.value,
          leading: const BackButton(
            color: Colors.white,
          ),
        ),
        body: controller.movieFromSlug == null  ?
        VideoLoading()
            :
        FadeIn(
          duration: const Duration(milliseconds: AppNumber.NUMBER_OF_DURATION_FADE_IN_MILLISECONDS),
          child: SingleChildScrollView(
            child: context.orientation==Orientation.landscape ?
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: context.width/2 ,
                          height: context.height*3/4,
                          child: BuildAvatarMovie(detailMovie: controller.movieFromSlug,controller: controller,)),
                      SizedBox(
                          width: context.width/2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: BuildContentMovie(controller: controller, detailMovie: controller.movieFromSlug),
                          )),
                    ],
                  ),
                  WidgetSize.sizedBoxHeight_10,
                  BuildDetailContentMovie(detailMovie: controller.movieFromSlug,controller: controller,listEpisodes: controller.listEpisodesMovieFromSlug),
                  BuildTabOption(controller: controller, heightEpisodes: controller.heightEpisodes, listEpisodes: controller.listEpisodesMovieFromSlug),
                ],
              )
                :
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BuildAvatarMovie(detailMovie: controller.movieFromSlug,controller: controller,),
                  BuildContentMovie(controller: controller, detailMovie: controller.movieFromSlug),
                  BuildDetailContentMovie(detailMovie: controller.movieFromSlug,controller: controller,listEpisodes: controller.listEpisodesMovieFromSlug),
                  BuildTabOption(controller: controller, heightEpisodes: controller.heightEpisodes, listEpisodes: controller.listEpisodesMovieFromSlug),
                ]
            ),
          ),
        ),
      );
    }) ;
  }
}







