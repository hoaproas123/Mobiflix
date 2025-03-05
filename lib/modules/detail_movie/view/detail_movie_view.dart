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

class DetailMovieView extends GetView<DetailController> {
  const DetailMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar:context.orientation==Orientation.landscape ?
        AppBar(
          backgroundColor: controller.textColor.value.withOpacity(0),
          toolbarHeight: 0,
          primary: false,
          leading: const BackButton(
            color: Colors.white,
          ),
        )
            :
        AppBar(
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
            child: Column(
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







