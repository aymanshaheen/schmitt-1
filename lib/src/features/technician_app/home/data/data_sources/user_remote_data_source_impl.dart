import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/api/endpoints.dart';
import 'package:schmitt/src/core/models/order_model.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/technician_app/home/data/data_sources/user_remote_data_source.dart';

class TechRemoteDataSourceImpl implements TechRemoteDataSource {
  final DioHelper dio;
  final FirebaseFirestore firestore;

  TechRemoteDataSourceImpl({
    required this.firestore,
    required this.dio,
  });

  @override
  Future<OrderListModel> getOrders(String status) async {
    try {
      Response response = await dio.getData(
          url: Endpoints.orders,
          token: AppConstants.token,
          query: {'page': 1, 'status': status});
      OrderListModel userModel = OrderListModel.fromJson(response.data);
      return userModel;
    } on DioException catch (error) {
      debugPrint('DioException occurred: ${error.message}');
      if (error.response != null) {
        debugPrint('HTTP status code: ${error.response?.statusCode}');
        debugPrint('Response data: ${error.response?.data}');
      } else {
        debugPrint('Response is null');
      }
      debugPrint('Request info: ${error.requestOptions}');
      rethrow;
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<OrderModel> markAsStart(File image, String id) async {
    try {
      Response response = await dio.postData(
          data: {
            'attachments[]': image,
          },
          url: Endpoints.orders + '/:id',
          token: AppConstants.token,
          path: {'id': id},
          query: {
            '_method': 'put',
          });
      OrderModel userModel = OrderModel.fromJson(response.data);
      return userModel;
    } on DioException catch (error) {
      debugPrint('DioException occurred: ${error.message}');
      if (error.response != null) {
        debugPrint('HTTP status code: ${error.response?.statusCode}');
        debugPrint('Response data: ${error.response?.data}');
      } else {
        debugPrint('Response is null');
      }
      debugPrint('Request info: ${error.requestOptions}');
      rethrow;
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<OrderModel> markAsComplete(File image, String id) async {
    try {
      Response response = await dio.postData(
          data: {
            'attachments[]': image,
          },
          url: Endpoints.orders + '/:id',
          token: AppConstants.token,
          path: {'id': id},
          query: {
            '_method': 'put',
          });
      OrderModel userModel = OrderModel.fromJson(response.data);
      return userModel;
    } on DioException catch (error) {
      debugPrint('DioException occurred: ${error.message}');
      if (error.response != null) {
        debugPrint('HTTP status code: ${error.response?.statusCode}');
        debugPrint('Response data: ${error.response?.data}');
      } else {
        debugPrint('Response is null');
      }
      debugPrint('Request info: ${error.requestOptions}');
      rethrow;
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<OrderModel> markAsProgress(String id) async {
    try {
      Response response = await dio.postData(
          data: {},
          url: Endpoints.orders + '/:id',
          token: AppConstants.token,
          path: {'id': id},
          query: {
            '_method': 'put',
          });
      OrderModel userModel = OrderModel.fromJson(response.data);
      return userModel;
    } on DioException catch (error) {
      debugPrint('DioException occurred: ${error.message}');
      if (error.response != null) {
        debugPrint('HTTP status code: ${error.response?.statusCode}');
        debugPrint('Response data: ${error.response?.data}');
      } else {
        debugPrint('Response is null');
      }
      debugPrint('Request info: ${error.requestOptions}');
      rethrow;
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }
}
