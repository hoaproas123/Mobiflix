import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/core/cache_manager.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:mobi_phim/services/domain_service.dart';
import 'package:mobi_phim/widgets/loading_screen_widget.dart';

class ListMovieHorizontalWidget extends StatelessWidget {
   ListMovieHorizontalWidget({
    super.key,
    required this.controller,
    required this.listMovie,
    this.changePage=false,
    this.title='',
  });

  final controller;
  final List<ItemMovieModel>? listMovie;
  final bool changePage;
  final String title;
  int currentPage=1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: context.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: List.generate(AppNumber.DEFAULT_NUMBER_OF_COLOR, (index) {
            double lightness = controller.hsl.lightness * (1 - (index * 0.17)); // Giảm 15% mỗi bước
            return controller.hsl.withLightness(lightness.clamp(0.0, 1.0)).toColor();
          }),
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: listMovie?.length==0 ?
      const Text(
        MovieString.NO_RESULT_TITLE,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,),
      )
          :
      ListView.builder(
        controller: controller.scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: listMovie?.length,
        itemBuilder: (context, index) {
          return index!=(listMovie?.length??1) - 1 ? //phần tử cuối list dùng trong chức năng genre thì thêm tính năng chuyển trang
            SizedBox(
            width: context.width,
            child: TextButton(
              onPressed: (){
                Get.toNamed(Routes.DETAIL_MOVIE,arguments: listMovie?[index].slug ?? DefaultString.NULL);
              },
              style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder( // Hình dạng button
                    borderRadius: BorderRadius.circular(10),
                  )),
                  overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.2))

              ),
              child: Card(
                color: Colors.transparent,
                elevation: 20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: (context.orientation==Orientation.portrait ? context.height : context.width) *1/7,
                      width: (context.orientation==Orientation.portrait ? context.width : context.height) *3/13,
                      child: FadeIn(
                        duration: const Duration(seconds: 1),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Card(
                                elevation: 10,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: Colors.transparent.withOpacity(0.1),
                                child: listMovie?[index].poster_url ==null ?
                                const SizedBox()
                                    :
                                CachedNetworkImage(
                                  imageUrl: title == MovieString.NEW_UPDATE_TITLE ?
                                  (listMovie![index].poster_url!)
                                      :
                                  DomainProvider.imgUrl+(listMovie![index].poster_url! ),
                                  cacheManager: MyCacheManager.instance,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => CardItemLoading(),
                                  errorWidget: (context, url, error) => CardItemLoading(),
                                )
                            ),
                            listMovie==null || changePage==true?
                            const SizedBox()
                                :
                            Positioned(
                                bottom: 1,
                                child: Container(
                                  height: (context.orientation==Orientation.portrait ? context.height : context.width) *1/56,
                                  width: (context.orientation==Orientation.portrait ? context.width : context.height) *1/10,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.red.shade500,
                                      borderRadius: BorderRadius.circular(3)
                                  ),
                                  child: Text(
                                    (listMovie![index].episode_current??DefaultString.NULL).contains(MovieString.COMPLETED_MOVIE_TITLE1) ||
                                        (listMovie![index].episode_current??DefaultString.NULL).contains(MovieString.COMPLETED_MOVIE_TITLE2) ?
                                            listMovie![index].quality ?? DefaultString.NULL : MovieString.NEW_EPISODE_TITLE,
                                    style: const TextStyle(
                                        fontSize: 7,
                                        color: Colors.white
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    SizedBox(
                        width: context.width*8/13,
                        child: Text(listMovie?[index].name ?? DefaultString.NULL,style: const TextStyle(fontSize: 18,color: Colors.white),)
                    )
                  ],
                ),
              ),
            ),
          )
              :
          Column(
            children: [
              SizedBox(
                width: context.width,
                child: TextButton(
                  onPressed: (){
                    Get.toNamed(Routes.DETAIL_MOVIE,arguments: listMovie?[index].slug??DefaultString.NULL);
                  },
                  style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder( // Hình dạng button
                        borderRadius: BorderRadius.circular(10),
                      )),
                      overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.2))

                  ),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: (context.orientation==Orientation.portrait ? context.height : context.width) *1/7,
                          width: (context.orientation==Orientation.portrait ? context.width : context.height) *3/13,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Card(
                                  elevation: 10,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Colors.transparent.withOpacity(0.1),
                                  child: listMovie?[index].poster_url ==null ?
                                  const SizedBox()
                                      :
                                  Ink.image(
                                    image: NetworkImage(
                                      title == MovieString.NEW_UPDATE_TITLE ? (listMovie![index].poster_url!)
                                          :
                                      DomainProvider.imgUrl+(listMovie![index].poster_url! ),
                                    ),
                                    fit: BoxFit.fill,
                                  )
                              ),
                              listMovie==null || changePage==true?
                              const SizedBox()
                                  :
                              Positioned(
                                  bottom: 1,
                                  child: Container(
                                    height: (context.orientation==Orientation.portrait ? context.height : context.width) *1/56,
                                    width: (context.orientation==Orientation.portrait ? context.width : context.height) *1/10,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.red.shade500,
                                        borderRadius: BorderRadius.circular(3)
                                    ),
                                    child: Text(
                                      (listMovie![index].episode_current??DefaultString.NULL).contains(MovieString.COMPLETED_MOVIE_TITLE1) ||
                                          (listMovie![index].episode_current??DefaultString.NULL).contains(MovieString.COMPLETED_MOVIE_TITLE2) ?
                                              listMovie![index].quality ?? DefaultString.NULL : MovieString.NEW_EPISODE_TITLE,
                                      style: const TextStyle(
                                          fontSize: 7,
                                          color: Colors.white
                                      ),
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                        SizedBox(
                            width: context.width*8/13,
                            child: Text(listMovie?[index].name ?? DefaultString.NULL ,style: const TextStyle(fontSize: 18,color: Colors.white),)
                        )
                      ],
                    ),
                  ),
                ),
              ),
              changePage==true && listMovie!=null?
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: IconButton(
                        onPressed: (){
                          controller.genreMovieData(1);
                          controller.scrollToTop();
                        },
                        icon: const Icon(Icons.keyboard_arrow_left_rounded),
                        color: Colors.white,
                        style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                            side: WidgetStatePropertyAll(BorderSide(width: 1,color: Colors.white)),
                            minimumSize: WidgetStatePropertyAll(Size(30,30)),

                        ),
                      ),
                    )
                  ]
                    +
                      List.generate(6, (index) {
                    int totalPage=(controller.movieByGenre?.pagination?.totalPages ?? 0);
                    int lastPage=totalPage -(5-index);
                    int currentPage=(controller.movieByGenre?.pagination?.currentPage ?? 0);
                    int firstPage=currentPage +index-1;
                    int remainPage=totalPage-currentPage;
                    String numOfPage=remainPage <=2 ? lastPage.toString():
                                    (index ==3 ? '...' :
                                    index >3 ? lastPage.toString() :
                                    firstPage.toString());
                    return lastPage>totalPage || firstPage<=0 || lastPage<=0?
                      const SizedBox()
                        :
                      SizedBox(
                        child: TextButton(
                        onPressed: (){
                          if(numOfPage!='...') {
                            controller.genreMovieData(int.parse(numOfPage));
                          }
                          controller.scrollToTop();
                        },
                        style: ButtonStyle(
                            padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
                            side: const WidgetStatePropertyAll(BorderSide(width: 1,color: Colors.white)),
                            minimumSize: const WidgetStatePropertyAll(Size(30,30)),
                            backgroundColor: currentPage.toString()==numOfPage ? const WidgetStatePropertyAll(Colors.white) :null
                        
                        ),
                        child: Text(
                          numOfPage,
                          style: TextStyle(
                              color: currentPage.toString()==numOfPage ? controller.hsl.withLightness(0.1).toColor() :Colors.white,
                              fontSize: 15
                          ),
                        ),
                                            ),
                      );
                  },),
                ),
              )
                :
              const SizedBox(),
            ],
          );
        },),
    );
  }
}