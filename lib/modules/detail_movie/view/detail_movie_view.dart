import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/modules/detail_movie/controller/detail_controller.dart';
import 'package:mobi_phim/models/episodes_movie.dart';
import 'package:mobi_phim/modules/detail_movie/widgets/avatar_movie_widget.dart';
import 'package:mobi_phim/modules/detail_movie/widgets/content_movie_widget.dart';
import 'package:mobi_phim/modules/detail_movie/widgets/detail_content_movie_widget.dart';
import 'package:mobi_phim/modules/detail_movie/widgets/tap_option_movie_widget.dart';
import 'package:mobi_phim/widgets/loading_screen_widget.dart';

class DetailMovieView extends GetView<DetailController> {
  const DetailMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    double heightEpisodes=AppNumber.AVG_NUMBER_OF_HEIGHT_PER_ROW;
    return Obx(() {
      ItemMovieModel? detailMovie= controller.movieFromSlug;
      List<EpisodesMovieModel>? listEpisodes= controller.listEpisodesMovieFromSlug;
      if(listEpisodes.isNotEmpty) {
        (listEpisodes[0].server_data?.length??AppNumber.NUMBER_OF_CHIP_EPOSIDES_PER_ROW) <=AppNumber.NUMBER_OF_CHIP_EPOSIDES_PER_ROW ? heightEpisodes : heightEpisodes=((listEpisodes[0].server_data?.length??AppNumber.NUMBER_OF_CHIP_EPOSIDES_PER_ROW)/AppNumber.NUMBER_OF_CHIP_EPOSIDES_PER_ROW).ceil()*heightEpisodes ;
      }
      return Scaffold(
        backgroundColor: Colors.black,

        appBar:context.orientation==Orientation.landscape ?
        AppBar(
          backgroundColor: controller.textColor.value.withOpacity(0),
          toolbarHeight: 0,
          primary: false,
          leading: BackButton(
            color: Colors.white,
            onPressed: (){
              if (controller.youtubePlayerController !=null &&controller.youtubePlayerController!.value.isPlaying) {
                controller.youtubePlayerController?.pause();
              }
              Get.back();
            },
          ),
        )
            :
        AppBar(
          backgroundColor: controller.textColor.value,
          leading: BackButton(
            color: Colors.white,
            onPressed: (){
              if (controller.youtubePlayerController !=null &&controller.youtubePlayerController!.value.isPlaying) {
                controller.youtubePlayerController?.pause();
              }
              Get.back();
            },
          ),
        ),
        body: detailMovie == null  ?
        VideoLoading()
            :
        FadeIn(
          duration: const Duration(milliseconds: AppNumber.NUMBER_OF_DURATION_FADE_IN_MILLISECONDS),
          child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BuildAvatarMovie(detailMovie: detailMovie,controller: controller,),
                  BuildContentMovie(controller: controller, detailMovie: detailMovie),
                  BuildDetailContentMovie(detailMovie: detailMovie,controller: controller,listEpisodes: listEpisodes),
                  BuildTabOption(controller: controller, heightEpisodes: heightEpisodes, listEpisodes: listEpisodes),
                ]
            ),
          ),
        ),
      );
    }) ;
  }
}







