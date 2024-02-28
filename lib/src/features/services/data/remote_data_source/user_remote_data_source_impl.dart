import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/api/endpoints.dart';
import 'package:schmitt/src/core/usecase/address_params.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/services/data/model/adresses_model.dart';
import 'package:schmitt/src/features/services/data/model/review_model.dart';
import 'package:schmitt/src/features/services/data/remote_data_source/user_remote_data_source.dart';

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final DioHelper dio;

  ServiceRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<ReviewModel> getReviwes(String id, String category) async {
    try {
      Response response = await dio.getData(
          url: Endpoints.services + ':id/' + Endpoints.reviews,
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
  Future<AddressModel> getAddresses() async {
    try {
      Response response = await dio.getData(
          url: Endpoints.addresses, token: AppConstants.token);
      AddressModel userModel = AddressModel.fromJson(response.data);
      return userModel;
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<AddressDataModel> createAddress(AddressParams params) async {
    try {
      Response response = await dio.postData(
          data: params.toJson(),
          url: Endpoints.addresses,
          token: AppConstants.token);
      AddressDataModel userModel = AddressDataModel.fromJson(response.data);
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
          url: Endpoints.service + ':id/' + Endpoints.reviews,
          path: {'id': id},
          token: AppConstants.token);
      return response.data;
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }
}
