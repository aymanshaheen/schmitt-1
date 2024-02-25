import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/features/home/data/data_sources/user_remote_data_source_impl.dart';
import 'package:schmitt/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:schmitt/src/features/home/domain/use_cases/add_bokmark_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/bokmark_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/delete_bokmark_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/delete_notifications_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/get_user_by_id_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/mark_all_seen_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/notifications_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/show_profile_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/update_profile_usecase.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';

import '../../container_injector.dart';
import '../../core/api/dio_helper.dart';
import '../../core/network/network_info.dart';

void initHome() {
  sl.registerLazySingleton<HomeRemoteDataSourceImpl>(
    () => HomeRemoteDataSourceImpl(
        dio: sl<DioHelper>(), firestore: sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton(
    () => HomeRepositoryImpl(
      networkInfo: sl<NetworkInfoImpl>(),
      remoteDataSource: sl<HomeRemoteDataSourceImpl>(),
      appPreferences: sl<AppPreferences>(),
    ),
  );
  sl.registerLazySingleton(
    () => ShowProfileUseCase(repository: sl<HomeRepositoryImpl>()),
  );
  sl.registerLazySingleton(
    () => BookMarkListUseCase(repository: sl<HomeRepositoryImpl>()),
  );
  sl.registerLazySingleton(
    () => DeleteNotificationsListUseCase(repository: sl<HomeRepositoryImpl>()),
  );
  sl.registerLazySingleton(
    () => MarkAllSeenListUseCase(repository: sl<HomeRepositoryImpl>()),
  );
  sl.registerLazySingleton(
    () => NotificationsListUseCase(repository: sl<HomeRepositoryImpl>()),
  );
  sl.registerLazySingleton(
    () => AddBookMarkListUseCase(repository: sl<HomeRepositoryImpl>()),
  );
  sl.registerLazySingleton(
    () => UpdateProfileUseCase(repository: sl<HomeRepositoryImpl>()),
  );
  sl.registerLazySingleton(
    () => DeleteBookMarkListUseCase(repository: sl<HomeRepositoryImpl>()),
  );
  sl.registerLazySingleton(() => GetUserByIdUseCase(sl<HomeRepositoryImpl>()));
  sl.registerFactory(
    () => HomeCubit(
      bookMarkListUseCase: sl<BookMarkListUseCase>(),
      showProfileUseCase: sl<ShowProfileUseCase>(),
      updateProfileUseCase: sl<UpdateProfileUseCase>(),
      markAllSeenListUseCase: sl<MarkAllSeenListUseCase>(),
      deleteNotificationsListUseCase: sl<DeleteNotificationsListUseCase>(),
      notificationsListUseCase: sl<NotificationsListUseCase>(),
      addBookMarkListUseCase: sl<AddBookMarkListUseCase>(),
      deleteBookMarkListUseCase: sl<DeleteBookMarkListUseCase>(),
      getUserByIdUseCase: sl<GetUserByIdUseCase>(),
    ),
  );
}
