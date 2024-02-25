import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:schmitt/src/core/error/error_handler.dart';
import 'package:schmitt/src/core/error/response_status.dart';
import 'package:schmitt/src/core/network/network_info.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/auth/data/model/user_model_save.dart';
import 'package:schmitt/src/features/auth/data/remote_data_source/user_remote_data_source.dart';
import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:schmitt/src/features/auth/domain/repository/user_repository.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_in_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_up_usecase.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final AppPreferences appPreferences;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.appPreferences,
  });
/*
  @override
  ResultVoid forgotPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.forgotPassword(email);

        return const Right(null);
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }
*/
  @override
  ResultVoid googleAuth() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.googleAuth();
        return Right(result);
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }
 @override
  ResultVoid facebookAuth() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.facebookAuth();
        return Right(result);
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }
  @override
 /* ResultVoid saveUserDataToFirebase(UserEntity user) async {
    final result = await remoteDataSource.saveUserDataToFirebase(user);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ErrorHandler.handle(failure.message!).failure);
    }
  }*/

  @override
  Future<Either<Failure, UserModelSave>> getCurrentUser() async {
    final result = await remoteDataSource.getCurrentUser();
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(Failure(message: failure.message.toString(), code: 0));
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  ResultFuture<UserEntity> signIn(SignInParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.signIn(params);
        appPreferences.saveData(key: 'token', value: result.token);
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

  
/*
  @override
  ResultVoid signOut() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.signOut();
        return const Right(null);
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }*/

  @override
  ResultFuture<UserEntity> signUp(SignUpParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.signUp(params);
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
}
