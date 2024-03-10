
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/error/error_handler.dart';
import 'package:schmitt/src/core/error/response_status.dart';
import 'package:schmitt/src/core/network/network_info.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/orders/data/data_sources/user_remote_data_source.dart';
import 'package:schmitt/src/features/orders/domain/repositories/home_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
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
  ResultFuture<void> updateOrder(String date,String addressId,int orderId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.updateOrder(date,addressId,orderId);
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
  ResultFuture<String> cancleOrder(int orderId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.cancleOrder(orderId);
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
