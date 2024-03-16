import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:schmitt/src/core/error/error_handler.dart';
import 'package:schmitt/src/core/error/response_status.dart';
import 'package:schmitt/src/core/network/network_info.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_up_usecase.dart';
import 'package:schmitt/src/features/home/data/data_sources/user_remote_data_source.dart';
import 'package:schmitt/src/features/home/domain/entities/notification.dart';
import 'package:schmitt/src/features/home/domain/entities/slides.dart';
import 'package:schmitt/src/features/home/domain/repositories/home_repository.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final AppPreferences appPreferences;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.appPreferences,
  });

  @override
  ResultFuture<UserEntity> showProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.showProfile();
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
  Stream<UserEntity> getUserById(String id) {
    return remoteDataSource.getUserById(id);
  }

  @override
  ResultFuture<ServiceEntity> bookmarkList(String category) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.bookMarkList(category);
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
  ResultFuture<String> addBookMark(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.addBookMark(id);
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
  ResultFuture<Notifications> notificationList() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.notificationsList();
        return right(result as Notifications);
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
  ResultFuture<String> markAllSeen() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.markAllSeen();
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
  ResultFuture<UserEntity> updateProfile(SignUpParams parameters) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.updateProfile(parameters);
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
  ResultFuture<String> deleteBookMark(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.deleteBookMark(id);
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
  ResultFuture<String> deleteNotification(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.deleteNotification(id);
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
  ResultFuture<SliderEntity> getSlides() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getSlides();
        return right(result);
      } on DioException catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  ResultFuture<ServiceEntity> getServices(int page, String category) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getServices(page, category);
        return right(result);
      } on DioException catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }
}
