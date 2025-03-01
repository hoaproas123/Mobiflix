import 'package:get/get.dart';
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/modules/genre_movie/model/genre_movie_model.dart';
import '../../../services/http_provider.dart';

class GenreMovieProvider extends GetConnect {


  final HttpProvider http;

  GenreMovieProvider({required this.http});

  Future<BaseResponse?> loadData(GenreMovieModel genreMovieModel) async {
    return await http.doPost(genreMovieModel.url??"", null).then((response) {
      return BaseResponse(
          statusCode: response.statusCode,
          statusText: response.statusMessage,
          status: response.data['status'].toString(),
          data: response.data['data'] ?? {},
          items: response.data['items'] ?? {},
          pagination: response.data['pagination'] ?? {},
          message:
              response.data['message'] ?? "");
    }).catchError((onError) {
      return BaseResponse(statusText: onError.toString(), statusCode: 400);
    });
  }
}
