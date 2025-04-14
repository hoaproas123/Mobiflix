import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/modules/detail_movie/controller/detail_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BuildAvatarMovie extends StatelessWidget {
  const BuildAvatarMovie({
    super.key,
    required this.detailMovie,
    required this.controller,
  });

  final ItemMovieModel? detailMovie;
  final DetailController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.orientation==Orientation.portrait ? context.height/3 : context.height,
      width: context.width,
      child: detailMovie?.trailer_url != DefaultString.NULL && controller.youtubePlayerController!=null?
      YoutubePlayer(
        controller: controller.youtubePlayerController!,
        progressIndicatorColor: Colors.red,
      )
          :
      Image.network(
        errorBuilder: (context, error, stackTrace) => Image.asset('assets/icon/no_image.png',fit: BoxFit.fill,color: Colors.white,),
        detailMovie?.thumb_url?? DefaultString.NULL,
        fit: BoxFit.fill,
      ),
    );
  }
}