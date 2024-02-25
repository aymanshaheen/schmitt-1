import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/network/network_info.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/features/auth/data/remote_data_source/user_remote_data_source.dart';
import 'package:schmitt/src/features/auth/data/remote_data_source/user_remote_data_source_impl.dart';
import 'package:schmitt/src/features/auth/data/repository/user_repository_impl.dart';
import 'package:schmitt/src/features/auth/domain/repository/user_repository.dart';
import 'package:schmitt/src/features/auth/domain/usercases/facebook_auth_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/forgot_password_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/get_current_user_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/google_auth_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_in_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_out_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_up_usecase.dart';
import 'package:schmitt/src/features/auth/presentation/cubit/auth_cubit.dart';

Future<void> initAuth() async {
  //Cubit or Bloc

  sl.registerFactory<CredentialCubit>(() => CredentialCubit(
      forgotPasswordUseCase: sl.call(),
      facebookAuthUseCase: sl.call(),
      getCurrentUserUseCase: sl.call(),
      googleAuthUseCase: sl.call(),
      signInUseCase: sl.call(),
      signUpUseCase: sl.call()));

  //UseCases
  sl.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(repository: sl.call()));
  sl.registerLazySingleton<GoogleAuthUseCase>(
      () => GoogleAuthUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(sl.call()));
  sl.registerLazySingleton<FacebookAuthUseCase>(
      () => FacebookAuthUseCase(sl.call()));    

  /*sl.registerLazySingleton<SaveUserDataToFirebaseUseCase>(
      () => SaveUserDataToFirebaseUseCase(sl.call()));*/

  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  sl.registerLazySingleton<FacebookAuth>(() => FacebookAuth.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      remoteDataSource: sl.call(),
      networkInfo: sl<NetworkInfoImpl>(),
      appPreferences: sl<AppPreferences>()));

  // RemoteDataSource

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      firestore: sl.call(),
      googleSignIn: sl.call(),
      storage: sl.call(),
      dio: sl<DioHelper>(),
      faceBookAuth: sl.call(),
      auth: sl<FirebaseAuth>(),
    ),
  );
}
