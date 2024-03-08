import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/network/network_info.dart';
import 'package:schmitt/src/features/packages/data/data_sources/package_remote_data_source_impl.dart';
import 'package:schmitt/src/features/packages/data/repositories/package_repository_impl.dart';
import 'package:schmitt/src/features/packages/domain/use_cases/add_review.dart';
import 'package:schmitt/src/features/packages/domain/use_cases/get_package.dart';
import 'package:schmitt/src/features/packages/domain/use_cases/get_packages.dart';
import 'package:schmitt/src/features/packages/domain/use_cases/get_reviews.dart';
import 'package:schmitt/src/features/packages/presentation/cubit/package_cubit.dart';

void initPackages() {
  sl.registerLazySingleton<PackageRemoteDataSourceImpl>(
    () => PackageRemoteDataSourceImpl(dio: sl<DioHelper>()),
  );
  sl.registerLazySingleton(
    () => PackageRepositoryImpl(
      networkInfo: sl<NetworkInfoImpl>(),
      remoteDataSource: sl<PackageRemoteDataSourceImpl>(),
      appPreferences: sl<AppPreferences>(),
    ),
  );

  // UseCase
  sl.registerLazySingleton(
      () => GetPackageUseCase(repository: sl<PackageRepositoryImpl>()));
  sl.registerLazySingleton(
      () => GetPackagesUseCase(repository: sl<PackageRepositoryImpl>()));
  sl.registerLazySingleton(
      () => AddReviweUseCase(repository: sl<PackageRepositoryImpl>()));
  sl.registerLazySingleton(
      () => GetReviwesUseCase(repository: sl<PackageRepositoryImpl>()));
  // Bloc
  sl.registerFactory(
    () => PackageCubit(
      getPackageUseCase: sl<GetPackageUseCase>(),
      getPackagesUseCase: sl<GetPackagesUseCase>(),
      addReviweUseCase: sl<AddReviweUseCase>(),
      getReviwesUseCase: sl<GetReviwesUseCase>(),
    ),
  );
}
