
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/modules/search_movie/controller/search_controller.dart';
import 'package:mobi_phim/widgets/list_movie_horizontal_widget.dart';


class SearchView extends GetView<SearchMovieController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<ItemMovieModel>? listMovie=controller.movieBySearch.value.list_movie ;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: controller.backgroundColor,
          leading: const BackButton(color: Colors.white,style: ButtonStyle(iconSize: WidgetStatePropertyAll(30)),),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  controller.onSearchChanged(value);
                  listMovie=controller.movieBySearch.value.list_movie;
                },
                style: const TextStyle(color: Colors.white,fontSize: 20),
                decoration: InputDecoration(
                  hintText: AppString.SEARCH_HINT_TITLE,
                  hintStyle: const TextStyle(color: Colors.white54,fontSize: 20),
                  prefixIcon: const Icon(Icons.search,color: Colors.white54,size: 40,),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Transform.scale(
                    scale: 0.7,
                    child: controller.isLoading.value==false ?
                    null
                      :
                    const CircularProgressIndicator(
                      color: Colors.red,
                      strokeWidth: 7,
                    ),
                  ),

                  filled: true,
                  fillColor: Colors.grey.shade800,
                ),
              ),
            ),
          ),


        ),
        body: ListMovieHorizontalWidget(controller: controller, listMovie: listMovie),
      );
    },);
  }
}






