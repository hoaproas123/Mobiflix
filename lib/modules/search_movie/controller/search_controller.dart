
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/core/alert.dart';
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/models/movies_model.dart';
import 'package:mobi_phim/modules/search_movie/model/search_model.dart';
import 'package:mobi_phim/modules/search_movie/repository/search_repository.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:mobi_phim/services/domain_service.dart';

class SearchMovieController extends GetxController with GetTickerProviderStateMixin{
  final SearchRepository searchRepository;
  SearchModel? searchModel;
  SearchMovieController({required this.searchRepository});
  Rx<MoviesModel> movieBySearch=MoviesModel().obs;
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  RxBool isLoading= false.obs;
  Color backgroundColor = Get.arguments[0];
  HSLColor hsl = Get.arguments[1];
  String addQuery =Get.arguments[2];
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    await searchMovieData("a");
  }
  ///***************************
  Future<void> searchMovieData(String searchString) async {
    final BaseResponse? response;
    response = await searchRepository.loadData(
        SearchModel(
          url: DomainProvider.search + searchString + DomainProvider.limit60 + addQuery,));
    update();
    if (response?.statusCode == HttpStatus.ok) {
      if(response?.status == AppReponseString.STATUS_SUCCESS) {//success with 'data' and true with 'items' and 'movies'
        if(response?.data !=null){
          movieBySearch.value=MoviesModel.fromJson(response!.data!,DefaultString.NULL);
        }
        // _updateBackgroundColor(listNewUpdateMovie[0].poster_url??"");
        isLoading.value=false;
      }
      else {
        Alert.showError(
            title: CommonString.ERROR,
            message:CommonString.ERROR_DATA_MESSAGE,
            buttonText:  CommonString.CANCEL);
      }
    } else {
      Alert.showError(
          title: CommonString.ERROR,
          message:CommonString.ERROR_URL_MESSAGE,
          buttonText:  CommonString.CANCEL);
    }
    // Alert.closeLoadingIndicator();
  }
  void onSearchChanged(String searchString) {

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      if (searchString.isNotEmpty) {
        Future.delayed(const Duration(seconds: 2),() {
          isLoading.value=true;
          searchMovieData(searchString);
        },);
      }
    });
  }
  onButtonCardPress(String slug){
    Get.toNamed(Routes.DETAIL_MOVIE,arguments: slug);
  }
  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }


}