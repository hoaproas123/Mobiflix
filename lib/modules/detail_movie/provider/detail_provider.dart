import 'package:get/get.dart';
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/modules/detail_movie/model/detail_model.dart';

import '../../../services/http_provider.dart';

class DetailProvider extends GetConnect {


  final HttpProvider http;

  DetailProvider({required this.http});

  Future<BaseResponse?> loadData(DetailModel detailModel) async {
    return await http.doPost(detailModel.url??"", null).then((response) {
      return BaseResponse(
          statusCode: response.statusCode,
          statusText: response.statusMessage,
          status: response.data['status'].toString(),
          movies: response.data['movie'] ?? {},
          movies_episodes: response.data['episodes'] ?? [],
          message:
              response.data['message'] ?? "");
    }).catchError((onError) {
      return BaseResponse(statusText: onError.toString(), statusCode: 400);
    });
  }
}
