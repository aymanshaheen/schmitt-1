import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/api/endpoints.dart';
import 'package:schmitt/src/core/models/order_model.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/packages/data/data_sources/package_remote_data_source.dart';


class PackageRemoteDataSourceImpl implements PackageRemoteDataSource {
  final DioHelper dio;
  final FirebaseFirestore firestore;

  PackageRemoteDataSourceImpl({
    required this.firestore,
    required this.dio,
  });

  @override
  Future<PackageModel> getPackages() async {
    try {
      Response response =
          await dio.getData(url: Endpoints.package, token: AppConstants.token);
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


}
