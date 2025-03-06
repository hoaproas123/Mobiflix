
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/core/cache_manager.dart';
import 'package:mobi_phim/models/episodes_movie.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:mobi_phim/services/domain_service.dart';
import 'package:mobi_phim/widgets/loading_screen_widget.dart';
import 'package:mobi_phim/widgets/widgets.dart';
class HighlightMovieWidget extends StatelessWidget {
  const HighlightMovieWidget({
    required this.controller,
    this.url=true,

    super.key,
  });
  final controller;
  final bool url;
  @override
  Widget build(BuildContext context) {
    return controller.firstMovieItem==null || controller.movieFromSlug==null?
    Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 280,
          height: 400,
          child: Card(
              elevation: 50,
              clipBehavior: Clip.antiAlias,
              color: Colors.transparent,
              child: CardHighLightLoading()
          ),
        ),
      ),
    )
        :
    context.orientation==Orientation.portrait ?
    Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 280,
                height: 400,
                child: FadeIn(
                  duration: const Duration(seconds: 1),
                  child: Card(
                    elevation: 50,
                    clipBehavior: Clip.antiAlias,
                    color: Colors.transparent,
                    child: controller.firstMovieItem==null ?
                    const SizedBox()
                    :
                    CachedNetworkImage(
                      imageUrl: url == true ? controller.firstMovieItem?.poster_url ?? DefaultString.NULL : DomainProvider.imgUrl + controller.firstMovieItem!.poster_url!,
                      cacheManager: MyCacheManager.instance,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>CardHighLightLoading(),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey,
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                      imageBuilder: (context, imageProvider) => Ink.image(
                        image: imageProvider,
                        fit: BoxFit.fill,
                        child: InkWell(
                          overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.1)),
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_MOVIE, arguments: controller.firstMovieItem?.slug ?? DefaultString.NULL);
                          },
                        ),
                      ),
                    )
                  ),
                ),
              ),
              Positioned(
                  width: 130,
                  bottom: 30,
                  child: Center(
                    child: MaterialButton(
                      onPressed: () async {
                        String slug= controller.firstMovieItem.slug;
                        List<EpisodesMovieModel>? listEpisodes= controller.listEpisodesMovieFromSlug;
                        List inforSave=await controller.getSavedEpisode(slug);
                        int server = int.parse(inforSave[0]);
                        int episode = int.parse(inforSave[1]);
                        controller.saveEpisode(server,episode+1);
                        // print(controller.firstMovieItem.slug);
                        Get.toNamed(Routes.PLAY_MOVIE, arguments: [server,episode+1, slug,listEpisodes]);
                      },
                      color: Colors.white,
                      child: const Row(
                        children: [
                          Icon(Icons.play_arrow,color: Colors.black,size: 30,),
                          SizedBox(width: 5,),
                          Text(AppString.PLAY_BUTTON,style: TextStyle(fontSize: 20,color: Colors.black),)
                        ],
                      ),
                    ),
                  )
              )
            ],
          ),
          Container(
            width: context.width-30,
            alignment: Alignment.center,
            child: Text(
              controller.firstMovieItem?.name?? DefaultString.NULL,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],

      ),
    )
    :
    Padding(
      padding: const EdgeInsets.only(top: 30.0,left: 8,right: 8),
      child: SizedBox(
        width: context.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: context.width*2/7,
              height: context.height*3/4,
              child: FadeIn(
                duration: const Duration(seconds: 1),
                child: Card(
                    elevation: 50,
                    clipBehavior: Clip.antiAlias,
                    color: Colors.transparent,
                    child: controller.firstMovieItem==null ?
                    const SizedBox()
                        :
                    CachedNetworkImage(
                      imageUrl: url == true ? controller.firstMovieItem?.poster_url ?? DefaultString.NULL : DomainProvider.imgUrl + controller.firstMovieItem!.poster_url!,
                      cacheManager: MyCacheManager.instance,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>CardHighLightLoading(),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey,
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                      imageBuilder: (context, imageProvider) => Ink.image(
                        image: imageProvider,
                        fit: BoxFit.fill,
                        child: InkWell(
                          overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.1)),
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_MOVIE, arguments: controller.firstMovieItem?.slug ?? DefaultString.NULL);
                          },
                        ),
                      ),
                    )
                ),
              ),
            ),
            SizedBox(
              height: context.height*3/4,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WidgetSize.sizedBoxHeight_5,
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(Routes.DETAIL_MOVIE, arguments: controller.firstMovieItem?.slug ?? DefaultString.NULL);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 6),
                        child: Text(
                          controller.firstMovieItem?.name?? DefaultString.NULL,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.width/2,
                      child: Html(
                        data: controller.movieFromSlug?.content?? DefaultString.NULL,
                        style: {
                          "body": Style(
                            color: Colors.white,      // Đổi màu chữ thành trắng
                            fontSize: FontSize(15.0), // Đổi kích thước chữ thành 15
                            maxLines: 3,
                            textAlign: TextAlign.justify,
                            textOverflow: TextOverflow.ellipsis
                          ),
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:  1.0,horizontal: 6),
                      child: SizedBox(
                        width: context.width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,

                                  ),
                                  child: Text(
                                    controller.movieFromSlug?.quality?? DefaultString.NULL,
                                    style: TextStyle(
                                      color: Colors.black,      // Đổi màu chữ thành trắng
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                WidgetSize.sizedBoxWidth_10,
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.withOpacity(0.1),
                                      border: Border.all(color: Colors.white.withOpacity(0.5))

                                  ),
                                  child: Text(
                                    controller.movieFromSlug?.lang?? DefaultString.NULL,
                                    style: TextStyle(
                                        color: Colors.white,      // Đổi màu chữ thành trắng
                                        fontSize: 15.0,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                controller.movieFromSlug?.status ==MovieString.STATUS_COMPLETED ? MovieString.SHOW_COMPLETED_STATUS : "${controller.movieFromSlug?.episode_current ?? DefaultString.NULL}/${controller.movieFromSlug?.episode_total ?? DefaultString.NULL}",
                                style: TextStyle(
                                    color: Colors.white,      // Đổi màu chữ thành trắng
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:  6.0,horizontal: 6),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,

                            ),
                            child: Text(
                              controller.movieFromSlug?.list_country[0].name?? DefaultString.NULL,
                              style: TextStyle(
                                color: Colors.black,      // Đổi màu chữ thành trắng
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          WidgetSize.sizedBoxWidth_10,
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(color: Colors.white.withOpacity(0.5))

                            ),
                            child: Text(
                              controller.movieFromSlug?.year?? DefaultString.NULL,
                              style: TextStyle(
                                color: Colors.white,      // Đổi màu chữ thành trắng
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: context.width/2,
                      child: Wrap(
                        children: List.generate(controller.movieFromSlug?.list_category.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical:  4.0,horizontal: 6),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.withOpacity(0.2)
                              ),
                              child: Text(
                                  controller.movieFromSlug?.list_category[index].name,
                                style: TextStyle(
                                  color: Colors.white,      // Đổi màu chữ thành trắng
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          );
                        },),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: SizedBox(
                        width: context.width/2,
                        child: MaterialButton(
                          onPressed: () async {
                            String slug= controller.firstMovieItem.slug;
                            List<EpisodesMovieModel>? listEpisodes= controller.listEpisodesMovieFromSlug;
                            List inforSave=await controller.getSavedEpisode(slug);
                            int server = int.parse(inforSave[0]);
                            int episode = int.parse(inforSave[1]);
                            controller.saveEpisode(server,episode+1);
                            // print(controller.firstMovieItem.slug);
                            Get.toNamed(Routes.PLAY_MOVIE, arguments: [server,episode+1, slug,listEpisodes]);
                          },
                          color: Colors.white,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.play_arrow,color: Colors.black,size: 30,),
                              SizedBox(width: 5,),
                              Text(AppString.PLAY_BUTTON,style: TextStyle(fontSize: 20,color: Colors.black),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

