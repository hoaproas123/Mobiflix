import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/core/cache_manager.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/models/movies_model.dart';
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
    super.key,
  });
  final String title;
  final int? index;
  final bool url;
  final bool isHome;
  List<ItemMovieModel>? listMovie;
  MoviesModel? moviesModel;
  final controller;
  @override
  Widget build(BuildContext context) {
    if(index ==null) {
      moviesModel= controller.listMovieModel.length != 0 ? controller.listMovieModel[0] :MoviesModel();
      listMovie= controller.listNewUpdateMovie;
      }
    else {
      moviesModel=  controller.listMovieModel[index!]!;
      listMovie=moviesModel?.list_movie ?? [];
      }
    return
      Column(
      children: [
        InkWell(
          onTap: () {
            String selectYear='';
            String selectCountry='';
            String category='';
            if(isHome==false){
              selectYear= controller.selectYear.value=="Năm"? '' : '&year=${controller.selectYear.value}';
              selectCountry=controller.selectCountry.value.slug=="Quốc Gia"? '' : '&country=${controller.selectCountry.value.slug}';
              category=index ==null ? '' : "&category=${controller.listMovieModel[index].pagination!.filterCategory!}";
            }
            String addQuery=selectYear+selectCountry+category;
            String slug='';
            if(index==null){
              if(isHome==true){
                slug="${DomainProvider.newUpdateMovieV2}?";
              }
              else{
                slug="${DomainProvider.moviesByGenre}${moviesModel?.detail_Page?.og_url ?? ""}?&sort_field=modified.time";
              }
            }
            else{
              if(isHome==true){
                slug="${DomainProvider.moviesByGenre}${moviesModel?.detail_Page?.og_url ?? ""}?";
              }
              else{
                slug="${DomainProvider.moviesByGenre}${moviesModel?.detail_Page?.og_url ?? ""}?";
              }
            }
            Get.toNamed('/home/genreMovie',arguments: [controller.backgroundColor.value,controller.hsl.value,addQuery,title,slug]);
          },
          child: Hero(
            tag: title,
            child: Container(
              width: context.width,
              padding: const EdgeInsets.all(10),
              child: AnimatedGradientText(
                text: title,
                colors: List.generate(4, (index) {
                  double lightness = HSLColor.fromColor(Colors.white).lightness * (1 - (index * 0.25)); // Giảm 15% mỗi bước
                  return HSLColor.fromColor(Colors.white).withLightness(lightness.clamp(0.0, 1.0)).toColor();
                }),
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              cacheExtent: 20,
              itemCount: listMovie?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 8),
                  child: SizedBox(
                    width: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        FadeIn(
                          duration: const Duration(seconds: 1),
                          child: Card(
                            elevation: 10,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Colors.transparent.withOpacity(0.1),
                            child: CachedNetworkImage(
                              imageUrl: (this.index == null)
                                  ? url==true ? listMovie![index].poster_url! : DomainProvider.imgUrl + listMovie![index].poster_url!
                                  : DomainProvider.imgUrl + listMovie![index].poster_url!,
                              cacheManager: MyCacheManager.instance,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => CardItemLoading(),
                              errorWidget: (context, url, error) => CardItemLoading(),
                              imageBuilder: (context, imageProvider) => Ink.image(
                                image: imageProvider,
                                fit: BoxFit.fill,
                                child: InkWell(
                                  overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.2)),
                                  onTap: () {
                                    Get.toNamed('home/detailMovie', arguments: listMovie![index].slug ?? "");
                                  },
                                ),
                              ),
                            )
                          ),
                        ),
                        this.index==null ?
                        Positioned(
                            bottom: 5,
                            child: Container(
                              height: context.height*1/36,
                              width: context.width*1/6,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.red.shade500,
                                  borderRadius: BorderRadius.circular(3)
                              ),
                              child: Text(
                                url == false ?
                                listMovie![index].episode_current!.contains('Hoàn Tất') || listMovie![index].episode_current!.contains("Full") ?'Mới Thêm':'Tập Mới'
                                  :
                                listMovie![index].status =='completed' ?'Mới Thêm':'Tập Mới',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white
                                ),
                              ),
                            )
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
