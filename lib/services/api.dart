

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {

  static final Dio _dio = Dio(
    BaseOptions(
      contentType: 'application/json',
      baseUrl: 'https://api.leadhornet.in/api/',
      // connectTimeout: const Duration(milliseconds: 5000),
      // receiveTimeout: const Duration(milliseconds: 50000),

    ),

  )..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));
  const Api();

  static Future<Response> postRequest(
      String url, {
        Map<String, dynamic>? data,
        FormData? formData,
      }) async {
    return await _dio.post(url, data: formData ?? data);
  }
}