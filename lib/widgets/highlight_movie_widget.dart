
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/core/cache_manager.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:mobi_phim/services/domain_service.dart';
import 'package:mobi_phim/widgets/loading_screen_widget.dart';
import 'package:mobi_phim/widgets/widgets.dart';

class ListHighlightMovieWidget extends StatelessWidget {
  const ListHighlightMovieWidget({
    required this.controller,

    super.key,
  });
  final controller;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: List.generate(10,(index) {
        return HighlightMovieWidget(controller: controller,index: index,);
      },),
      options: CarouselOptions(
        height: context.orientation==Orientation.portrait ? 480.0 :  272.0,
        autoPlay: true,
        autoPlayInterval: const Duration(minutes: 1),
        viewportFraction: 1,
        disableCenter: true,
        onPageChanged: (index, reason) {
          Future.delayed(const Duration(milliseconds: 800),() {
            controller.backgroundColor.value=controller.listBackgroundColor[index];
            controller.hsl.value=controller.listHSLBackgroundColor[index];
          },);
        },

      ),
    );
  }
}

class HighlightMovieWidget extends StatelessWidget {
  const HighlightMovieWidget({
    required this.controller,
    this.url=true,
    this.index=0,
    super.key,
  });
  final controller;
  final bool url;
  final int index;
  @override
  Widget build(BuildContext context) {
    ItemMovieModel? firstMovieItem = controller.listNewUpdateMovie?.length<=index ? null : controller.listNewUpdateMovie?[index];
    ItemMovieModel? movieFromSlug;
    try{
      movieFromSlug = controller.listMovieFromSlug?.length<=index ? null :controller.listMovieFromSlug?[index];
    }
    catch(e){
      movieFromSlug = controller.movieFromSlug.value;
    }
    return context.orientation==Orientation.portrait ?
    firstMovieItem==null || movieFromSlug==null?
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
    Padding(
      key: ValueKey(firstMovieItem.slug),
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              FadeIn(
                duration: const Duration(seconds: 1),
                child: SizedBox(
                  width: 280,
                  child: Card(
                    elevation: 50,
                    clipBehavior: Clip.antiAlias,
                    color: Colors.transparent,
                    child: CachedNetworkImage(
                      imageUrl: url == true ? firstMovieItem.poster_url ?? DefaultString.NULL : DomainProvider.imgUrl + firstMovieItem.poster_url!,
                      cacheManager: MyCacheManager.instance,
                      height: 400,
                      placeholder: (context, url) =>CardHighLightLoading(),
                      errorWidget: (context, url, error) => Image.asset('assets/icon/no_image.png',fit: BoxFit.fill,color: Colors.white,),
                      imageBuilder: (context, imageProvider) => Ink.image(
                        image: imageProvider,
                        fit: BoxFit.fitWidth,
                        child: InkWell(
                          overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.1)),
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_MOVIE, arguments: firstMovieItem.slug ?? DefaultString.NULL);
                          },
                        ),
                      ),
                    )
                  ),
                ),
              ),
              Positioned(
                  width: 120,
                  bottom: 30,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () => controller.onPlayButtonPress(firstMovieItem.slug,controller.listEpisodesMovieFromSlug?[index]),
                          color: Colors.white,
                          child: const Row(
                            children: [
                              Icon(Icons.play_arrow,color: Colors.black,size: 30,),
                              SizedBox(width: 5,),
                              Text(AppString.PLAY_BUTTON,style: TextStyle(fontSize: 20,color: Colors.black),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
          WidgetSize.sizedBoxHeight_10,
          Container(
            width: context.width-30,
            alignment: Alignment.center,
            child: Text(
              firstMovieItem.name?? DefaultString.NULL,
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
    firstMovieItem==null || movieFromSlug==null?
    Padding(
      padding: const EdgeInsets.only(top: 5.0,left: 8,right: 8),
      child: SizedBox(
        width: context.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: context.width*0.25,
              height: context.height*0.68,
              child: Card(
                  elevation: 50,
                  clipBehavior: Clip.antiAlias,
                  color: Colors.transparent,
                  child: CardHighLightLoading()
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                width: context.width/2,
                height: context.height*0.68,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    )
        :
    Padding(
      key: ValueKey(firstMovieItem.slug),
      padding: const EdgeInsets.only(top: 5.0,left: 8,right: 8),
      child: SizedBox(
        width: context.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: context.width*0.25,
              height: context.height*0.68,
              child: FadeIn(
                duration: const Duration(seconds: 1),
                child: Card(
                    elevation: 50,
                    clipBehavior: Clip.antiAlias,
                    color: Colors.transparent,
                    child: CachedNetworkImage(
                      imageUrl: url == true ? firstMovieItem.poster_url ?? DefaultString.NULL : DomainProvider.imgUrl + firstMovieItem.poster_url!,
                      cacheManager: MyCacheManager.instance,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>CardHighLightLoading(),
                      errorWidget: (context, url, error) => Image.asset('assets/icon/no_image.png',fit: BoxFit.fill,color: Colors.white,),
                      imageBuilder: (context, imageProvider) => Ink.image(
                        image: imageProvider,
                        fit: BoxFit.fill,
                        child: InkWell(
                          overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.1)),
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_MOVIE, arguments: firstMovieItem.slug ?? DefaultString.NULL);
                          },
                        ),
                      ),
                    )
                ),
              ),
            ),
            SizedBox(
              height: context.height*0.68,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(Routes.DETAIL_MOVIE, arguments: firstMovieItem.slug ?? DefaultString.NULL);
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 6),
                        width: context.width/2,
                        child: Text(
                          firstMovieItem.name?? DefaultString.NULL,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: context.width*0.03,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.width/2,
                      child: Html(
                        data: movieFromSlug.content?? DefaultString.NULL,
                        style: {
                          "body": Style(
                            color: Colors.white,      // Đổi màu chữ thành trắng
                            fontSize: FontSize(context.width*0.02), // Đổi kích thước chữ thành 15
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
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                  ),
                                  child: Text(
                                    movieFromSlug.quality?? DefaultString.NULL,
                                    style: TextStyle(
                                      color: Colors.black,      // Đổi màu chữ thành trắng
                                      fontSize: context.width*0.02,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                WidgetSize.sizedBoxWidth_10,
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  constraints: BoxConstraints(maxWidth: context.width*0.25),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.withOpacity(0.1),
                                      border: Border.all(color: Colors.white.withOpacity(0.5))

                                  ),
                                  child: Text(
                                    movieFromSlug.lang?? DefaultString.NULL,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,      // Đổi màu chữ thành trắng
                                        fontSize: context.width*0.02,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                movieFromSlug.status ==MovieString.STATUS_COMPLETED ? MovieString.SHOW_COMPLETED_STATUS : "${movieFromSlug.episode_current ?? DefaultString.NULL}/${movieFromSlug.episode_total ?? DefaultString.NULL}",
                                style: TextStyle(
                                    color: Colors.white,      // Đổi màu chữ thành trắng
                                    fontSize: context.width*0.02,
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
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,

                            ),
                            child: Text(
                              movieFromSlug.list_country?[0].name?? DefaultString.NULL,
                              style: TextStyle(
                                color: Colors.black,      // Đổi màu chữ thành trắng
                                fontSize: context.width*0.02,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          WidgetSize.sizedBoxWidth_10,
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(color: Colors.white.withOpacity(0.5))

                            ),
                            child: Text(
                              movieFromSlug.year?? DefaultString.NULL,
                              style: TextStyle(
                                color: Colors.white,      // Đổi màu chữ thành trắng
                                fontSize: context.width*0.02,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: context.width/2,
                      child: Wrap(
                        children: List.generate(movieFromSlug.list_category!.length, (index) {
                          return index > 2 ?
                          const SizedBox()
                              :
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:  2.0,horizontal: 6),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.withOpacity(0.2)
                              ),
                              child: Text(
                                  movieFromSlug?.list_category?[index].name??DefaultString.NULL,
                                style: TextStyle(
                                  color: Colors.white,      // Đổi màu chữ thành trắng
                                  fontSize: context.width*0.02,
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
                          onPressed: () => controller.onPlayButtonPress(firstMovieItem.slug,controller.listEpisodesMovieFromSlug?[index]),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.play_arrow,color: Colors.black,size: context.width*0.05,),
                              const SizedBox(width: 5,),
                              Text(AppString.PLAY_BUTTON,style: TextStyle(fontSize: context.width*0.03,color: Colors.black),)
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

