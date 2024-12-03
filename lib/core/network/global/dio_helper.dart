import 'package:dio/dio.dart';
import 'package:firebase_test/core/services/get_server_key.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio;

  static initDioHelper() async {
    dio = Dio(
        BaseOptions(baseUrl: "", receiveDataWhenStatusError: true, headers: {
      "Authorization": 'Bearer ${await GetServerKey.getServerKeyToken()}',
    }));

    // customization
    dio!.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  static Future<Response> getData(
      {required String endpoint, Map<String, dynamic>? queryParameters}) async {
    return await dio!.get(endpoint, queryParameters: queryParameters);
  }

  static Future<Response> postData(
      {required String endpoint, required Map<String, dynamic> data}) async {
    return await dio!.post(endpoint, data: data);
  }
}
