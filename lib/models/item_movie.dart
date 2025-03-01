
import 'package:equatable/equatable.dart';
import 'package:mobi_phim/models/category_item.dart';
import 'package:mobi_phim/models/country_item.dart';

class ItemMovieModel extends Equatable {
  String? id;
  String? name;
  String? origin_name;
  String? content;
  String? slug;
  String? type;
  String? status;
  String? poster_url;
  String? thumb_url;
  bool? sub_docquyen;
  bool? chieurap;
  String? trailer_url;
  String? time;
  String? episode_current;
  String? episode_total;
  String? quality;
  String? lang;
  String? year;
  List<String>? actor;
  List<String>? director;
  List<CategoryItemModel>? list_category;
  List<CountryItemModel>? list_country;


  ItemMovieModel({
      this.id,
      this.name,
      this.origin_name,
      this.content,
      this.slug,
      this.type,
      this.status,
      this.poster_url,
      this.thumb_url,
      this.sub_docquyen,
      this.chieurap,
      this.trailer_url,
      this.time,
      this.episode_current,
      this.episode_total,
      this.quality,
      this.lang,
      this.year,
      this.actor,
      this.director,
      this.list_category,
      this.list_country});

  factory ItemMovieModel.fromJson(Map<String, dynamic> json) {
    List<CategoryItemModel> listCategoryMovie=[];
    if(json["category"]!=null){
      json["category"].forEach((item){
        listCategoryMovie.add(CategoryItemModel.fromJson(item));
      });
    }
    List<CountryItemModel> listCountryMovie=[];
    if(json["country"]!=null){
      json["country"].forEach((item){
        listCountryMovie.add(CountryItemModel.fromJson(item));
      });
    }
    List<String> listActor=[];
    if(json["actor"]!=null){
      json["actor"].forEach((item){
        listActor.add(item);
      });
    }
    List<String> listDirector=[];
    if(json["director"]!=null){
      json["director"].forEach((item){
        listDirector.add(item);
      });
    }

    return ItemMovieModel(
        id: json['id'],
        name: json['name'],
        origin_name: json['origin_name'],
        content: json['content'],
        slug: json['slug'],
        type: json['type'],
        status: json['status'],
        poster_url: json['poster_url'],
        thumb_url: json['thumb_url'],
        sub_docquyen: json['sub_docquyen'],
        chieurap: json['chieurap'],
        trailer_url: json['trailer_url'],
        time: json['time'],
        episode_current: json['episode_current'],
        episode_total: json['episode_total'],
        quality: json['quality'],
        lang: json['lang'],
        year: json['year'].toString(),
        actor: listActor,
        director: listDirector,
        list_category: listCategoryMovie,
        list_country: listCountryMovie,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;

    return data;
  }

  @override
  List<Object?> get props => [
        id,
        type,
        name,

      ];
}
