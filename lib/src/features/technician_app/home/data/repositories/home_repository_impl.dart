import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/error/error_handler.dart';
import 'package:schmitt/src/core/error/response_status.dart';
import 'package:schmitt/src/core/network/network_info.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/technician_app/home/data/data_sources/user_remote_data_source.dart';
import 'package:schmitt/src/features/technician_app/home/domain/repositories/home_repository.dart';

class TechRepositoryImpl implements TechRepository {
  final TechRemoteDataSource remoteDataSource;
  final AppPreferences appPreferences;
  final NetworkInfo networkInfo;

  TechRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.appPreferences,
  });

  @override
  ResultFuture<OrderListEntity> getOrders(String status) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getOrders(status);
        return right(result);
      } on DioException catch (e) {
        return Left(Failure(message: e.response!.data['message'], code: 0));
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  ResultFuture<OrderEntity> markAsStart(File image, String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.markAsStart(image, id);
        return right(result);
      } on DioException catch (e) {
        return Left(Failure(message: e.response!.data['message'], code: 0));
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  ResultFuture<OrderEntity> markAsComplete(File image, String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.markAsComplete(image, id);
        return right(result);
      } on DioException catch (e) {
        return Left(Failure(message: e.response!.data['message'], code: 0));
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  ResultFuture<OrderEntity> markAsProgress(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.markAsProgress(id);
        return right(result);
      } on DioException catch (e) {
        return Left(Failure(message: e.response!.data['message'], code: 0));
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }
}
