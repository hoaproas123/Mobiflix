import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpProvider  {
  final Dio httpClient;

  HttpProvider({required this.httpClient});

  Future<Response> doPost(String url, dynamic data) {
    var endpoint = dotenv.env['BASEURL'].toString() + url;
    return httpClient.post(
      endpoint,
      data: data,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

  }
}
