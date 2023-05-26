import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static const String baseUrl = "https://staging.api.hr-portals.com/api/v1/";

  static init({String token = ""}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (status) {
          return status! <= 500;
        },
        receiveDataWhenStatusError: true,
        headers: {
          "authorization": "Bearer $token",
          "Accept": "application/json"
        },
      ),
    );
  }
}
/// interceprors