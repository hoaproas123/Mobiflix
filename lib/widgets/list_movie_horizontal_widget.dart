import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_colors.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/services/domain_service.dart';

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
          colors: AppColors.LINEAR_BACKGROUND_COLORS(controller.hsl),
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
        controller: controller.scrollController ,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: listMovie?.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                width: context.width,
                child: TextButton(
                  onPressed: (){
                    controller.onButtonCardPress(listMovie?[index].slug??DefaultString.NULL);
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
              index==(listMovie?.length??1) - 1 && changePage==true && listMovie!=null?
              controller.buildChangePaginationRow()
                :
              const SizedBox(),
            ],
          );
        },),
    );
  }
}