import 'package:equatable/equatable.dart';

class BaseResponse extends Equatable {
  final String? status;
  final int? statusCode;
  final String? statusText;
  final data;
  final movies;
  final movies_episodes;
  final items;
  final pagination;
  final String? message;
  final Map<String, dynamic>? lang;

  BaseResponse(
      {this.status,
      this.statusCode,
      this.statusText,
      this.data,
      this.message,
      this.lang,
      this.movies,
      this.movies_episodes,
      this.pagination,
      this.items,});

  Map<String, dynamic> toMap() {
    return {
      "status": status,
      "statusCode": statusCode,
      "data": data,
      "statusText": statusText,
      "message": message,
      "lang": lang,
    };
  }

  factory BaseResponse.fromMap(Map<String, dynamic> map) {
    return BaseResponse(
        statusCode: map['statusCode'],
        statusText: map['statusText'],
        status: map['error'],
        data: map['data'],
        message: map['message'],
        lang: map['lang']);
  }

  @override
  List<Object?> get props =>
      [status, statusCode, data, statusText, message, lang];
}
