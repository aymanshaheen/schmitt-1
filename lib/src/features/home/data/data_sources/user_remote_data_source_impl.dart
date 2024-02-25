import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/api/endpoints.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/auth/data/model/user_model.dart';
import 'package:schmitt/src/features/auth/data/model/user_model_save.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_up_usecase.dart';
import 'package:schmitt/src/features/home/data/data_sources/user_remote_data_source.dart';
import 'package:schmitt/src/features/home/data/model/bookmark_model.dart';
import 'package:schmitt/src/features/home/data/model/notification_model.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioHelper dio;
  final FirebaseFirestore firestore;

  HomeRemoteDataSourceImpl({
    required this.firestore,
    required this.dio,
  });

  @override
  Future<UserModel> showProfile() async {
    try {
      Response response =
          await dio.getData(url: Endpoints.profile, token: AppConstants.token);
      UserModel userModel = UserModel.fromJson(response.data);
      return userModel;
    }  on DioException catch (error) {
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
  Stream<UserModelSave> getUserById(String id) {
    return firestore.collection('users').doc(id).snapshots().map(
      (event) {
        return UserModelSave.fromMap(event.data()!);
      }
    );
  }
  @override
  Future<UserModel> updateProfile(SignUpParams user) async {
    try {
      final response = await dio.postData(
          url: Endpoints.profile,
          data: user.toJson(),
          token: AppConstants.token,
          query: {
            '_method': 'put',
          });
      final userModel = UserModel.fromJson(response.data);
      return userModel;
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
    @override
  Future<BookMarkModel> bookMarkList() async {
    try {
      Response response = await dio.getData(
          url: Endpoints.favouriteList, token: AppConstants.token);
      BookMarkModel userModel = BookMarkModel.fromJson(response.data);
      return userModel;
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<String> deleteBookMark(String id) async {
    try {
      Response response = await dio.deleteData(
          url: Endpoints.services+':service/' + Endpoints.unfavourite,
          path: {'service': id},
          token: AppConstants.token);
      return response.data['message'];
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> addBookMark(String id) async {
    try {
      Response response = await dio.postData(
          data: {},
          url:Endpoints.services+ ':service/' + Endpoints.favourite,
          path: {'service': id},
          token: AppConstants.token);
      return response.data['message'];
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
   @override
  Future<NotificationsModel> notificationsList() async {
    try {
      Response response = await dio.getData(
          url: Endpoints.notification, token: AppConstants.token);
      NotificationsModel userModel = NotificationsModel.fromJson(response.data);
      return userModel;
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<String> deleteNotification(String id) async {
    try {
      Response response = await dio.deleteData(
          url: Endpoints.notification+':id',
          path: {'id': id},
          token: AppConstants.token);
      return response.data['message'];
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> markAllSeen() async {
    try {
      Response response = await dio.postData(
          data: {},
          url:Endpoints.notificationSeen,
          token: AppConstants.token);
      return response.data['message'];
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
