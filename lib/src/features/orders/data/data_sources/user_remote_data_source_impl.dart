import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/api/endpoints.dart';
import 'package:schmitt/src/core/models/order_model.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/orders/data/data_sources/user_remote_data_source.dart';

class OrderDataSourceImpl implements OrderDataSource {
  final DioHelper dio;

  OrderDataSourceImpl({
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
  Future<void> updateOrder(String date, String addressId, int orderId) async {
    try {
      await dio.postData(
          data: {"date": date, "address_id": addressId},
          url: Endpoints.orders + "/:id",
          token: AppConstants.token,
          path: {"id": orderId.toString()},
          query: {
            "_method": "PUT",
          });
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
  Future<String> cancleOrder(int orderId) async {
    try {
      Response response = await dio.postData(
        data: {},
        url: Endpoints.orders + "/:id/" + Endpoints.cancel,
        token: AppConstants.token,
        path: {"id": orderId.toString()},
      );
      return response.data;
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
