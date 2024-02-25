import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/api/endpoints.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/services/data/model/review_model.dart';
import 'package:schmitt/src/features/services/data/remote_data_source/user_remote_data_source.dart';

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final DioHelper dio;

  ServiceRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<ReviewModel> getReviwes(String id) async {
    try {
      Response response = await dio.getData(
          url: Endpoints.packages + ':id/' + Endpoints.reviews,
          path: {'id': id},
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
          url: Endpoints.packages + ':id/' + Endpoints.reviews,
          path: {'id': id},
          token: AppConstants.token);
      return response.data;
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }
}
