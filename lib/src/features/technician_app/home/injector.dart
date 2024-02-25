import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/network/network_info.dart';
import 'package:schmitt/src/features/technician_app/home/data/data_sources/user_remote_data_source_impl.dart';
import 'package:schmitt/src/features/technician_app/home/data/repositories/home_repository_impl.dart';
import 'package:schmitt/src/features/technician_app/home/domain/use_cases/get_orders.dart';
import 'package:schmitt/src/features/technician_app/home/domain/use_cases/mark_complete.dart';
import 'package:schmitt/src/features/technician_app/home/domain/use_cases/mark_progress.dart';
import 'package:schmitt/src/features/technician_app/home/domain/use_cases/mark_start.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/cubit/tech_cubit.dart';

void initTech() {
  sl.registerLazySingleton<TechRemoteDataSourceImpl>(
    () => TechRemoteDataSourceImpl(
        dio: sl<DioHelper>(), firestore: sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton(
    () => TechRepositoryImpl(
      networkInfo: sl<NetworkInfoImpl>(),
      remoteDataSource: sl<TechRemoteDataSourceImpl>(),
      appPreferences: sl<AppPreferences>(),
    ),
  );

  // UseCase
  sl.registerLazySingleton(
      () => GetOrdersUseCase(repository: sl<TechRepositoryImpl>()));
  sl.registerLazySingleton(
      () => MarkAsStartUseCase(repository: sl<TechRepositoryImpl>()));
  sl.registerLazySingleton(
      () => MarkAsCompleteUseCase(repository: sl<TechRepositoryImpl>()));
  sl.registerLazySingleton(
      () => MarkAsProgressUseCase(repository: sl<TechRepositoryImpl>()));

  // Bloc
  sl.registerFactory(
    () => TechCubit(
      getOrdersUseCase: sl<GetOrdersUseCase>(),
      markAsStartUseCase: sl<MarkAsStartUseCase>(),
      markAsProgressUseCase: sl<MarkAsProgressUseCase>(),
      markAsCompleteUseCase: sl<MarkAsCompleteUseCase>(),
    ),
  );
}
