/*
Use: Use get the data from API.
*/

import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_helper/src/api_certificates.dart';
import 'package:dio_helper/src/api_key.dart';
import 'package:flutter/services.dart';
import 'dio_error_entity.dart';
import 'dio_error_language_entity.dart';
import 'dio_method.dart';
import 'dio_return_error.dart';

const _apiTypeCollection = {
  DioMethod.get: 'get',
  DioMethod.post: 'post',
  DioMethod.delete: 'delete',
  DioMethod.put: 'put'
};

typedef ProgressCallback = void Function(int count, int total);

CancelToken cancelToken = CancelToken();

class DioHelper {
  late Dio dio;

  DioHelper({required this.dio});

  Future request<T>({
    DioMethod dioMethod = DioMethod.get,
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameter,
    Options? options,
    Map<String, dynamic>? header,
  }) async {
    try {
      SecurityContext sc = new SecurityContext(withTrustedRoots: false);

      BaseOptions baseOptions = BaseOptions(
        baseUrl: APiKey.baseUrlKey,
        receiveDataWhenStatusError: false,
        responseType: ResponseType.json,
        connectTimeout: 60000,
        receiveTimeout: 3000,
        headers: header,
      );

      dio = Dio(baseOptions)..interceptors.addAll(logInterceptor());
      
//       if(APiCertificates.certificatesAPI != null || APiCertificates.certificatesAPI != ""){
        try {
          List<int> bytes = [];
          bytes = (await rootBundle.load(APiCertificates.certificatesAPI))
              .buffer
              .asUint8List();

          sc.setTrustedCertificatesBytes(bytes);
        } on TlsException catch (e) {
          if (e.osError?.message != null &&
              e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
            print('createHttpClient() - cert already trusted! Skipping.');
          } else {
            print('createHttpClient().setTrustedCertificateBytes EXCEPTION: $e');
            rethrow;
          }
        }
//       }

      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        HttpClient httpClient = new HttpClient(context: sc);
        httpClient.badCertificateCallback =
            (X509Certificate cert, String host, int port) => false;

        return httpClient;
      };

      var response = await dio.request(
        path,
        data: data,
        onSendProgress: (received, total) {
          if (total != -1) {}
        },
        queryParameters: queryParameter,
        options: Options(method: _apiTypeCollection[dioMethod]),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return throw DioErrorEntity(
          statusCode: response.data['status_code'],
          errorLanguageEntity: DioErrorLanguageEntity(
            defaultLanguage: response.data['status_message'],
          ),
        );
      }
    } on DioError catch (e) {
      return throw (dioReturnError(e));
    }
  }

  List<Interceptor> logInterceptor() {
    return [LogInterceptor(requestBody: true, responseBody: true)];
  }
}
