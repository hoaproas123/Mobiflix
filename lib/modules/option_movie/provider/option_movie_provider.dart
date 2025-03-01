import 'package:get/get.dart';
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/modules/option_movie/model/option_movie_model.dart';

import '../../../services/http_provider.dart';

class OptionMovieProvider extends GetConnect {


  final HttpProvider http;

  OptionMovieProvider({required this.http});

  Future<BaseResponse?> loadData(OptionMovieModel optionMovieModel) async {
    return await http.doPost(optionMovieModel.url??"", null).then((response) {
      return BaseResponse(
          statusCode: response.statusCode,
          statusText: response.statusMessage,
          status: response.data['status'].toString(),
          data: response.data['data'] ?? {},
          message:
              response.data['message'] ?? "");
    }).catchError((onError) {
      return BaseResponse(statusText: onError.toString(), statusCode: 400);
    });
  }
}
