import 'package:get/get.dart';
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/modules/search_movie/model/search_model.dart';

import '../../../services/http_provider.dart';

class SearchProvider extends GetConnect {


  final HttpProvider http;

  SearchProvider({required this.http});

  Future<BaseResponse?> loadData(SearchModel searchModel) async {
    return await http.doPost(searchModel.url??"", null).then((response) {
      return BaseResponse(
          statusCode: response.statusCode,
          statusText: response.statusMessage,
          status: response.data['status'].toString(),
          data: response.data['data'] ?? {},
          movies: response.data['movie'] ?? {},
          movies_episodes: response.data['episodes'] ?? [],
          message:
              response.data['message'] ?? "");
    }).catchError((onError) {
      return BaseResponse(statusText: onError.toString(), statusCode: 400);
    });
  }
}
