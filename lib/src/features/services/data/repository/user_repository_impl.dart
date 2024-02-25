import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:schmitt/src/core/error/error_handler.dart';
import 'package:schmitt/src/core/error/response_status.dart';
import 'package:schmitt/src/core/network/network_info.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/data/remote_data_source/user_remote_data_source.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';
import 'package:schmitt/src/features/services/domain/repository/user_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource remoteDataSource;
  final AppPreferences appPreferences;
  final NetworkInfo networkInfo;

  ServiceRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.appPreferences,
  });

  @override
  ResultFuture<ReviewEntity> getReviews(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getReviwes(id);
        return right(result);
      } on DioException catch (e) {
        return Left(Failure(message: e.response!.data['message'].toString(), code: 0));
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

 @override
  ResultFuture<String> addReview(String id,String review,String rating) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.addReview(id,review,rating);
        return right(result);
      } on DioException catch (e) {
        return Left(Failure(message: e.response!.data['message'].toString(), code: 0));
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }
  
}
