
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/core/alert.dart';
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/models/movies_model.dart';
import 'package:mobi_phim/models/pagination_model.dart';
import 'package:mobi_phim/modules/genre_movie/model/genre_movie_model.dart';
import 'package:mobi_phim/modules/genre_movie/repository/genre_movie_repository.dart';
import 'package:mobi_phim/services/domain_service.dart';

import '../../../models/item_movie.dart';

class GenreMovieController extends GetxController with GetTickerProviderStateMixin{
  final GenreMovieRepository genreMovieRepository;
  GenreMovieModel? genreMovieModel;
  GenreMovieController({required this.genreMovieRepository});
  MoviesModel movieByGenre=MoviesModel();
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  Color backgroundColor = Get.arguments[0];
  HSLColor hsl = Get.arguments[1];
  String addQuery =Get.arguments[2];
  String title=Get.arguments[3];
  String slug=Get.arguments[4];
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    await genreMovieData(1);
  }
  ///***************************
  Future<void> genreMovieData(int page) async {
    final BaseResponse? response;
    response = await genreMovieRepository.loadData(
        GenreMovieModel(
          url:  '$slug${DomainProvider.limit20}&page=$page$addQuery',));
    update();
    if (response?.statusCode == HttpStatus.ok) {
      if(response?.status == AppReponseString.STATUS_SUCCESS) {//success with 'data' and true with 'items' and 'movies'
        if(response?.data !=null){
          movieByGenre=MoviesModel.fromJson(response!.data!,"");
        }
      }
      else {
        if(response?.status == true.toString()) {//success with 'data' and true with 'items' and 'movies'
          if(response?.items !=null){
            List<ItemMovieModel> listNewUpdateMovie=[];
            response?.items.forEach((item){
              listNewUpdateMovie.add(ItemMovieModel.fromJson(item));
            });
            movieByGenre=MoviesModel(
                list_movie: listNewUpdateMovie,
                pagination: PaginationModel(
                  currentPage: response?.pagination[MoviePaginationString.CURRENT_PAGE],
                  totalPages:  response?.pagination[MoviePaginationString.TOTAL_PAGE]
                )
            );
          }
        }
        else {
          Alert.showError(
              title: CommonString.ERROR,
              message:CommonString.ERROR_DATA_MESSAGE,
              buttonText:  CommonString.ERROR);
        }
      }
    } else {
        Alert.showError(
            title: CommonString.ERROR,
            message: CommonString.ERROR_URL_MESSAGE,
            buttonText:  CommonString.ERROR);
    }
    // Alert.closeLoadingIndicator();
  }
  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: AppNumber.NUMBER_OF_DURATION_SCROLL_MILLISECONDS),
      curve: Curves.easeInOut,
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }


}