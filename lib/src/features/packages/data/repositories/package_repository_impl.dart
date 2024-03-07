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
  ResultFuture<PackageEntity> getPackages() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPackages();
        return right(result);
      } on DioException catch (e) {
        return Left(Failure(message: e.response!.data['message'], code: 0));
      } catch (e) {
        return Left(ErrorHandler
            .handle(e)
            .failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }



}