import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:schmitt/src/core/error/error_handler.dart';
import 'package:schmitt/src/core/error/response_status.dart';
import 'package:schmitt/src/core/network/network_info.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/packages/data/data_sources/package_remote_data_source.dart';
import 'package:schmitt/src/features/packages/domain/entities/package_entity.dart';
import 'package:schmitt/src/features/packages/domain/repositories/package_repository.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';

class PackageRepositoryImpl implements PackageRepository {
  final PackageRemoteDataSource remoteDataSource;
  final AppPreferences appPreferences;
  final NetworkInfo networkInfo;

  PackageRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.appPreferences,
  });

  @override
  ResultFuture<PackagesEntity> getPackages(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPackages(page);
        return Right(result);
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
  ResultFuture<PackageEntity> getPackage(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPackage(id);
        return Right(result);
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
  ResultFuture<ReviewEntity> getReviews(String id, String category,int page) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getReviwes(id, category, page);
        return right(result);
      } on DioException catch (e) {
        return Left(
            Failure(message: e.response!.data['message'].toString(), code: 0));
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  ResultFuture<String> addReview(
      String id, String review, String rating) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.addReview(id, review, rating);
        return right(result);
      } on DioException catch (e) {
        return Left(
            Failure(message: e.response!.data['message'].toString(), code: 0));
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

}
