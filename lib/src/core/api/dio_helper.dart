import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/api/interceptors.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';

class DioHelper {
  late AppPreferences appPreferences;
  final Dio dio;

  DioHelper({required this.dio}) {
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      'Connection': 'keep-alive',
    };
    dio.options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveDataWhenStatusError: true,
      followRedirects: false,
      contentType:
          'multipart/form-data; boundary=<calculated when request is sent>',
      maxRedirects: 0,
      receiveTimeout: const Duration(minutes: 1),
      connectTimeout: const Duration(minutes: 1),
      headers: headers,
    );
    dio.interceptors.add(sl<LogInterceptor>());
    dio.interceptors.add(sl<AppInterceptors>());
  }

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? path,
    String? token,
    String? addressId,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'X-Address-ID': addressId,
      };
      if (path != null) {
        path.forEach((key, value) {
          url = url.replaceAll(':$key', value.toString());
        });
      }
      return await dio.get(
        url,
        queryParameters: query,
      );
    } on DioException catch (e) {
      log("here is a problem +${e.message}");
      if (e.response != null) {
      } else {
        // Something happened in setting up or sending the request that triggered an Error
      }
      rethrow;
    } catch (e) {
      log('another problem');
      rethrow;
    }
  }

  Future<Response> postData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? path,
    String? token,
    String? addressId,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Address-ID': addressId,
      };

      if (path != null) {
        path.forEach((key, value) {
          url = url.replaceAll(':$key', value.toString());
        });
      }
      Response response = await dio.post(
        url,
        queryParameters: query,
        data: data,
      );

      return response;
    } on DioException catch (e) {
      log("here is a problem +${e.message}");
      if (e.response != null) {
      } else {
        // Something happened in setting up or sending the request that triggered an Error
      }
      rethrow;
    } catch (e) {
      log('another problem');
      rethrow;
    }
  }

  Future<Response> postNotificationData({
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    Dio notificationDio = Dio(
      BaseOptions(
        baseUrl: AppConstants.sendNotificationUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        contentType:
            'multipart/form-data; boundary=<calculated when request is sent>',
        maxRedirects: 0,
        receiveTimeout: const Duration(minutes: 1),
        connectTimeout: const Duration(minutes: 1),
        headers: {
          'Authorization': AppConstants.serverToken,
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      ),
    );

    try {
      Response response = await notificationDio.post(
        '',
        queryParameters: query,
        data: data,
      );

      return response;
    } on DioException catch (e) {
      log("here is a problem +${e.message}");
      if (e.response != null) {
      } else {
        // Something happened in setting up or sending the request that triggered an Error
      }
      rethrow;
    } catch (e) {
      log('another problem');
      rethrow;
    }
  }

  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? path,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      if (path != null) {
        path.forEach((key, value) {
          url = url.replaceAll(':$key', value.toString());
        });
      }

      return await dio.delete(
        url,
        queryParameters: query,
      );
    } on DioException catch (e) {
      log("here is a problem +${e.message}");
      if (e.response != null) {
      } else {
        // Something happened in setting up or sending the request that triggered an Error
      }
      rethrow;
    } catch (e) {
      log('another problem');
      rethrow;
    }
  }

  Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
