import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/api/endpoints.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/packages/data/data_sources/package_remote_data_source.dart';
import 'package:schmitt/src/features/packages/data/model/package_model.dart';
import 'package:schmitt/src/features/services/data/model/review_model.dart';

class PackageRemoteDataSourceImpl implements PackageRemoteDataSource {
  final DioHelper dio;

  PackageRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<PackagesModel> getPackages(int page) async {
    try {
      Response response = await dio.getData(
          url: Endpoints.package,
          token: AppConstants.token,
          addressId: AppConstants.addressID);
      PackagesModel packageModel = PackagesModel.fromJson(response.data);
      return packageModel;
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
  Future<PackageModel> getPackage(String id) async {
    try {
      Response response = await dio.getData(
          url: Endpoints.package + "/:id",
          token: AppConstants.token,
          path: {'id': id},
          addressId: AppConstants.addressID);
      PackageModel packageModel = PackageModel.fromJson(response.data);
      return packageModel;
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
  Future<ReviewModel> getReviwes(String id, String category, int page) async {
    try {
      Response response = await dio.getData(
          url: Endpoints.package + '/:id/' + Endpoints.reviews,
          path: {'id': id},
          query: {'category_id': category},
          token: AppConstants.token);
      ReviewModel userModel = ReviewModel.fromJson(response.data);
      return userModel;
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<String> addReview(String id, String review, String rating) async {
    try {
      Response response = await dio.postData(
          data: {'review': review, 'rating': rating},
          url: Endpoints.package + '/:id/' + Endpoints.reviews,
          path: {'id': id},
          token: AppConstants.token);
      return response.data['message'];
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }
}
