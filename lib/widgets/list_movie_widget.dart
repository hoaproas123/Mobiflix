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
import 'package:mobi_phim/widgets/loading_screen_widget.dart';

class ListMovieWidget extends StatelessWidget {
   ListMovieWidget({
    required this.title,
    required this.controller,
    this.url=true,
    this.isHome=true,
    this.index,
    this.listType=ListType.GENRE_MOVIE,
    super.key,
  });
  final String title;
  final int? index;
  final bool url;
  final int listType;
  final bool isHome;
  List<ItemMovieModel>? listMovie;
  MoviesModel? moviesModel;
  final controller;
  @override
  Widget build(BuildContext context) {
    if(index ==null) {
      if(listType==ListType.NEW_UPDATE_MOVIE){
        moviesModel= controller.listMovieModel.length != 0 ? controller.listMovieModel[0] :MoviesModel();
        listMovie= controller.listNewUpdateMovie;
      }
      if(listType==ListType.CONTINUE_MOVIE_WATCH){
        moviesModel= controller.listMovieModel.length != 0 ? controller.listMovieModel[0] :MoviesModel();
        listMovie= controller.listContinueMovieModel.value;
      }
      if(listType==ListType.FAVORITE_MOVIE){
        moviesModel= controller.listMovieModel.length != 0 ? controller.listMovieModel[0] :MoviesModel();
        listMovie= controller.listFavoriteMovieModel.value;
      }
    }
    else {
      moviesModel=  controller.listMovieModel[index!]!;
      listMovie=moviesModel?.list_movie ?? [];
      }
    return listMovie?.length==0 ?
      const SizedBox()
        :
      Column(
      children: [
        InkWell(
          onTap: () {
            if(listType!=ListType.CONTINUE_MOVIE_WATCH){
              String selectYear=DefaultString.NULL;
              String selectCountry=DefaultString.NULL;
              String category=DefaultString.NULL;
              if(isHome==false){
                selectYear= controller.selectYear.value==DefaultString.YEAR? DefaultString.NULL : '&year=${controller.selectYear.value}';
                selectCountry=controller.selectCountry.value.slug==DefaultString.COUNTRY? DefaultString.NULL : '&country=${controller.selectCountry.value.slug}';
                category=index ==null ? DefaultString.NULL : "&category=${controller.listMovieModel[index].pagination!.filterCategory!}";
              }
              String addQuery=selectYear+selectCountry+category;
              String slug=DefaultString.NULL;
              if(index==null){
                if(isHome==true){
                  slug="${DomainProvider.newUpdateMovieV2}?";
                }
                else{
                  slug="${DomainProvider.moviesByGenre}${moviesModel?.detail_Page?.og_url ?? DefaultString.NULL}?&sort_field=modified.time";
                }
              }
              else{
                if(isHome==true){
                  slug="${DomainProvider.moviesByGenre}${moviesModel?.detail_Page?.og_url ?? DefaultString.NULL}?";
                }
                else{
                  slug="${DomainProvider.moviesByGenre}${moviesModel?.detail_Page?.og_url ?? DefaultString.NULL}?";
                }
              }
              Get.toNamed(Routes.GENRE_MOVIE,arguments: [controller.backgroundColor.value,controller.hsl.value,addQuery,title,slug]);
            }
          },
          child: Hero(
            tag: title,
            child: Container(
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
          ),
        ),
        Container(
            height: context.orientation==Orientation.portrait ? context.height*0.35 : context.width*0.3,
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              cacheExtent: 20,
              itemCount: listMovie?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SizedBox(
                    width: context.orientation==Orientation.portrait ? context.width*0.4 : context.height*0.38,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        FadeIn(
                          duration: const Duration(seconds: 1),
                          child: Card(
                            elevation: 10,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Colors.transparent,
                            child: CachedNetworkImage(
                              imageUrl: (this.index == null)
                                  ? url==true ? listMovie![index].poster_url! : DomainProvider.imgUrl + listMovie![index].poster_url!
                                  : DomainProvider.imgUrl + listMovie![index].poster_url!,
                              cacheManager: MyCacheManager.instance,
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
                        listType==ListType.CONTINUE_MOVIE_WATCH ?
                        Positioned(
                            child: IconButton(
                                onPressed: () => controller.onPlayButtonPress(listMovie?[index].slug,controller.listContinueEpisodeModel.value[index]),
                                icon: Icon(
                                  Icons.play_circle_outlined,
                                  size: context.width*0.2,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                            )
                        )
                        :
                        const SizedBox(),
                        listType==ListType.NEW_UPDATE_MOVIE ?
                        Positioned(
                            bottom: 5,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.red.shade500,
                                  borderRadius: BorderRadius.circular(context.width*0.01)
                              ),
                              child: Text(
                                url == false ?
                                listMovie![index].episode_current!.contains(MovieString.COMPLETED_MOVIE_TITLE1) ||
                                    listMovie![index].episode_current!.contains(MovieString.COMPLETED_MOVIE_TITLE2) ? MovieString.NEW_ADD_TITLE : MovieString.NEW_EPISODE_TITLE
                                  :
                                listMovie![index].status ==MovieString.STATUS_COMPLETED ? MovieString.NEW_ADD_TITLE : MovieString.NEW_EPISODE_TITLE,
                                style: TextStyle(
                                    fontSize: context.width*0.035,
                                    color: Colors.white
                                ),
                              ),
                            )
                        )
                            :
                        const SizedBox(),
                        listType==ListType.FAVORITE_MOVIE ?
                        Positioned(
                            top: -3,
                            right: -2,
                            child: Icon(
                              Icons.favorite,
                              size: 25,
                              color: Colors.pinkAccent,
                            ),
                        )
                            :
                        const SizedBox()
                      ],
                    ),
                  ),
                );
              },)
        ),
      ],
          );
  }
}
