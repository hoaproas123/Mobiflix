
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/modules/genre_movie/controller/genre_movie_controller.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:mobi_phim/widgets/list_movie_horizontal_widget.dart';
import 'package:mobi_phim/widgets/widgets.dart';


class GenreMovieView extends GetView<GenreMovieController> {
  const GenreMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GenreMovieController>(builder: (controller) {
      List<ItemMovieModel>? listMovie=controller.movieByGenre.list_movie;
      return Scaffold(
        backgroundColor: controller.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Hero(
            tag: controller.title,
            child: AppBar(
              backgroundColor: controller.backgroundColor,
              leading: const BackButton(color: Colors.white,style: ButtonStyle(iconSize: WidgetStatePropertyAll(30)),),
              title: Text(
                controller.title,
                style: const TextStyle(
                    color: Colors.white
                ),
              ),
              actions: [
                IconButton(
                  onPressed: (){
                    String addQuery=controller.addQuery;
                    Get.toNamed(Routes.SEARCH_MOVIE,arguments: [controller.backgroundColor,controller.hsl,addQuery]);
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                WidgetSize.sizedBoxWidth_10
              ],
            ),
          ),
        ),
        body: ListMovieHorizontalWidget(controller: controller, listMovie: listMovie,changePage: true,title: controller.title,),
      );
    },);
  }
}




