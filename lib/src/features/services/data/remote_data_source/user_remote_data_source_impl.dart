import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/api/endpoints.dart';
import 'package:schmitt/src/core/models/order_model.dart';
import 'package:schmitt/src/core/usecase/address_params.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/services/data/model/adresses_model.dart';
import 'package:schmitt/src/features/services/data/model/car_model.dart';
import 'package:schmitt/src/features/services/data/model/company_model.dart';
import 'package:schmitt/src/features/services/data/model/review_model.dart';
import 'package:schmitt/src/features/services/data/model/service_model.dart';
import 'package:schmitt/src/features/services/data/remote_data_source/user_remote_data_source.dart';
import 'package:schmitt/src/features/services/domain/entities/color.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_car.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_order_use_case.dart';

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
  Future<ServiceShowModel> getService(int id, String addressId) async {
    try {
      Response response = await dio.getData(
          url: Endpoints.services + ':id',
          token: AppConstants.token,
          path: {'id': id},
          addressId: addressId);
      ServiceShowModel userModel = ServiceShowModel.fromJson(response.data);
      return userModel;
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    } catch (e) {
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
  Future<AddressCreateModel> createAddress(AddressParams params) async {
    try {
      Response response = await dio.postData(
          data: params.toJson(),
          url: Endpoints.addresses,
          token: AppConstants.token);
      AddressCreateModel userModel = AddressCreateModel.fromJson(response.data);
      return userModel;
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<OrderModel> createOrder(OrderParams params, String addressId) async {
    try {
      Response response = await dio.postData(
          data: params.toJson(),
          url: Endpoints.orders,
          addressId: addressId,
          token: AppConstants.token);
      OrderModel userModel = OrderModel.fromJson(response.data);
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
          url: Endpoints.services + ':id/' + Endpoints.reviews,
          path: {'id': id},
          token: AppConstants.token);
      return response.data['message'];
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<CarsModel> getCars(int page) async {
    try {
      Response response =
          await dio.getData(url: Endpoints.cars, token: AppConstants.token);
      CarsModel userModel = CarsModel.fromJson(response.data);
      return userModel;
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<CarsShowModel> showCar(int id) async {
    try {
      Response response = await dio.getData(
          url: Endpoints.cars + '/:id',
          path: {'id': id.toString()},
          token: AppConstants.token);
      CarsShowModel userModel = CarsShowModel.fromJson(response.data);
      return userModel;
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> createCar(CarParams params) async {
    try {
      await dio.postData(
          data: params.toJson(),
          url: Endpoints.cars,
          token: AppConstants.token);
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> updateCar(CarParams params, int id) async {
    try {
      await dio.postData(
          data: params.toJson(),
          url: Endpoints.cars + '/:id',
          query: {
            '_method': 'put',
          },
          path: {'id': id.toString()},
          token: AppConstants.token);
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> deleteCar(int id) async {
    try {
      await dio.deleteData(
          url: Endpoints.cars + '/:id',
          path: {'id': id.toString()},
          token: AppConstants.token);
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<CompanyModel> getCompanies(int page, String addressId) async {
    try {
      Response response = await dio.getData(
          url: Endpoints.companies,
          token: AppConstants.token,
          addressId: addressId);
      CompanyModel userModel = CompanyModel.fromJson(response.data);
      return userModel;
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ColorModel> getColors(String addressId) async {
    try {
      Response response = await dio.getData(
          url: Endpoints.colors,
          token: AppConstants.token,
          addressId: addressId);
      ColorModel userModel = ColorModel.fromJson(response.data);
      return userModel;
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
   @override
  Future<void> updateAddress(AddressParams params, int id) async {
    try {
      await dio.postData(
          data: params.toJson(),
          url: Endpoints.addresses + '/:id',
          query: {
            '_method': 'put',
          },
          path: {'id': id.toString()},
          token: AppConstants.token);
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> deleteAddress(int id) async {
    try {
      await dio.deleteData(
          url: Endpoints.addresses + '/:id',
          path: {'id': id.toString()},
          token: AppConstants.token);
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

}
