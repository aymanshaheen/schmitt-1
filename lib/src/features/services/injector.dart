import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/network/network_info.dart';
import 'package:schmitt/src/features/services/data/remote_data_source/user_remote_data_source_impl.dart';
import 'package:schmitt/src/features/services/data/repository/user_repository_impl.dart';
import 'package:schmitt/src/features/services/domain/usercases/add_review.dart';
import 'package:schmitt/src/features/services/domain/usercases/get_reviews.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_cubit.dart';

void initServices() {
  sl.registerLazySingleton<ServiceRemoteDataSourceImpl>(
    () => ServiceRemoteDataSourceImpl(dio: sl<DioHelper>()),
  );
  sl.registerLazySingleton(
    () => ServiceRepositoryImpl(
      networkInfo: sl<NetworkInfoImpl>(),
      remoteDataSource: sl<ServiceRemoteDataSourceImpl>(),
      appPreferences: sl<AppPreferences>(),
    ),
  );

  // UseCase
  sl.registerLazySingleton(
      () => AddReviweUseCase(repository: sl<ServiceRepositoryImpl>()));
  sl.registerLazySingleton(
      () => GetReviwesUseCase(repository: sl<ServiceRepositoryImpl>()));

  // Bloc
  sl.registerFactory(
    () => ServiceCubit(
      addReviweUseCase: sl<AddReviweUseCase>(),
      getReviwesUseCase: sl<GetReviwesUseCase>(),
    ),
  );
}
