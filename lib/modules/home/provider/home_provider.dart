import 'package:get/get.dart';
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/modules/home/model/home_model.dart';

import '../../../services/http_provider.dart';

class HomeProvider extends GetConnect {


  final HttpProvider http;

  HomeProvider({required this.http});

  Future<BaseResponse?> loadData(HomeModel homeModel) async {
    return await http.doPost(homeModel.url??"", null).then((response) {
      return BaseResponse(
          statusCode: response.statusCode,
          statusText: response.statusMessage,
          status: response.data['status'].toString(),
          data: response.data['data'] ?? {},
          movies: response.data['movie'] ?? {},
          movies_episodes: response.data['episodes'] ?? [],
          items: response.data['items'] ?? {},
          message:
              response.data['message'] ?? "");
    }).catchError((onError) {
      return BaseResponse(statusText: onError.toString(), statusCode: 400);
    });
  }
}
