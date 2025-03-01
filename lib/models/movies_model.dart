import 'package:mobi_phim/models/page_detail_model.dart';
import 'package:mobi_phim/models/pagination_model.dart';

import 'item_movie.dart';

class MoviesModel  {
  String? title;
  String? titlePage;
  PageDetailModel? detail_Page;
  List<ItemMovieModel>? list_movie;
  PaginationModel? pagination;

  MoviesModel({
    this.title,
    this.titlePage,
    this.detail_Page,
    this.list_movie,
    this.pagination
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json,String title) {
    List<ItemMovieModel> listMovie=[];
    if(json["items"]!=null){
      json["items"].forEach((item){
        listMovie.add(ItemMovieModel.fromJson(item));
      });
    }
    return MoviesModel(
      title: title,
      titlePage: json['titlePage'],
      detail_Page: PageDetailModel.fromJson(json['seoOnPage']) ,
      list_movie: listMovie,
      pagination: PaginationModel.fromJson(json['params'])
    );
  }

}
