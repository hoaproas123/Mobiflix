import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_colors.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/modules/detail_movie/controller/detail_controller.dart';
import 'package:mobi_phim/widgets/animation_text_widget.dart';
import 'package:mobi_phim/widgets/widgets.dart';

class BuildContentMovie extends StatelessWidget {
  const BuildContentMovie({
    super.key,
    required this.controller,
    required this.detailMovie,
  });

  final DetailController controller;
  final ItemMovieModel? detailMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: WidgetSize.paddingPageAll_8,
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedGradientText(
                text: AppString.APP_NAME,
                colors: AppColors.TEXT_ANIMATION_COLORS(controller.hslText.value),
                fontSize: 30,
              ),
              WidgetSize.sizedBoxWidth_10,
              Text(
                detailMovie?.episode_total== AppNumber.COUNT_EPISODE_OF_MOVIE.toString() ? MovieString.MOVIE : MovieString.TV_SERIES,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Text(
            detailMovie?.name?? DefaultString.NULL,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
          ),
          Text(
            detailMovie?.origin_name?? DefaultString.NULL,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      detailMovie?.year?? DefaultString.NULL,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 15,
                      ),
                    ),
                    WidgetSize.sizedBoxWidth_30,
                    Container(
                      alignment: Alignment.center,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(3)
                      ),
                      child: Text(
                        detailMovie?.quality?? DefaultString.NULL,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  detailMovie?.status ==MovieString.STATUS_COMPLETED ? MovieString.SHOW_COMPLETED_STATUS : "${detailMovie?.episode_current ?? DefaultString.NULL}/${detailMovie?.episode_total ?? DefaultString.NULL}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}