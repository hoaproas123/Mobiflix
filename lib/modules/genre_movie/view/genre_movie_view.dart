
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/modules/genre_movie/controller/genre_movie_controller.dart';
import 'package:mobi_phim/widgets/list_movie_horizontal_widget.dart';
import 'package:mobi_phim/widgets/widgets.dart';


class GenreMovieView extends GetView<GenreMovieController> {
  const GenreMovieView({super.key});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => controller.onSearchPress(),
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
      body: Obx(() => ListMovieHorizontalWidget(controller: controller, listMovie: controller.movieByGenre.value.list_movie,changePage: true,title: controller.title,),)
    );
  }
}




