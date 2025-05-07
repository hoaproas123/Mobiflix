import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/core/cache_manager.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/models/movies_model.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:mobi_phim/services/domain_service.dart';
import 'package:mobi_phim/widgets/animation_text_widget.dart';
import 'package:mobi_phim/widgets/border_text_widget.dart';
import 'package:mobi_phim/widgets/loading_screen_widget.dart';

class ListTopMovieWidget extends StatelessWidget {
  ListTopMovieWidget({
    required this.title,
    required this.controller,
    super.key,
  });
  final String title;
  List<ItemMovieModel>? listMovie;
  MoviesModel? moviesModel;
  final controller;
  @override
  Widget build(BuildContext context) {
    listMovie= controller.listNewUpdateMovie;
    return listMovie?.length==0 ?
      const SizedBox()
        :
      Column(
      children: [
        Container(
          width: context.width,
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
          child: AnimatedGradientText(
            text: title,
            colors: List.generate(4, (index) {
              double lightness = HSLColor.fromColor(Colors.white).lightness * (1 - (index * 0.25)); // Giảm 15% mỗi bước
              return HSLColor.fromColor(Colors.white).withLightness(lightness.clamp(0.0, 1.0)).toColor();
            }),
            fontSize: context.orientation==Orientation.portrait ? context.width*0.045 : context.width*0.04,
          ),
        ),
        Container(
            height: context.orientation==Orientation.portrait ? context.height*0.25 : context.width*0.3,
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              cacheExtent: 60,
              itemCount: 8,
              itemBuilder: (context, index) {
                return listMovie!.length<=index ?
                SizedBox()
                  :
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom:-25,
                        left: 0,
                        child: BorderTextWidget(
                            text: (index+1).toString(),
                            color: controller.backgroundColor.value
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40,right: 10.0),
                        child: SizedBox(
                          width: context.orientation==Orientation.portrait ? context.width*0.3 : context.height*0.4,
                          child: FadeIn(
                            duration: const Duration(seconds: 1),
                            child: Card(
                              elevation: 10,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Colors.transparent.withOpacity(0.1),
                              child: CachedNetworkImage(
                                imageUrl:  listMovie![index].poster_url!,
                                cacheManager: MyCacheManager.instance,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => CardItemLoading(),
                                errorWidget: (context, url, error) {
                                  return Image.asset('assets/icon/no_image.png',fit: BoxFit.fill,color: Colors.white,);
                                },
                                imageBuilder: (context, imageProvider) => Ink.image(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                  child: InkWell(
                                    overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.2)),
                                    onTap: () {
                                      Get.toNamed(Routes.DETAIL_MOVIE, arguments: listMovie![index].slug ?? DefaultString.NULL);
                                    },
                                  ),
                                ),
                              )
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },)
        ),
      ],
          );
  }
}
