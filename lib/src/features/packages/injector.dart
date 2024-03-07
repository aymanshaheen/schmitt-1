import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/network/network_info.dart';
import 'package:schmitt/src/features/packages/data/data_sources/package_remote_data_source_impl.dart';
import 'package:schmitt/src/features/packages/data/repositories/package_repository_impl.dart';
import 'package:schmitt/src/features/services/data/remote_data_source/user_remote_data_source_impl.dart';
import 'package:schmitt/src/features/services/data/repository/user_repository_impl.dart';
import 'package:schmitt/src/features/services/domain/usercases/add_review.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_adress.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_car.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_order_use_case.dart';
import 'package:schmitt/src/features/services/domain/usercases/delete_address.dart';
import 'package:schmitt/src/features/services/domain/usercases/delete_car.dart';
import 'package:schmitt/src/features/services/domain/usercases/get_adresses.dart';
import 'package:schmitt/src/features/services/domain/usercases/get_cars.dart';
import 'package:schmitt/src/features/services/domain/usercases/get_colors.dart';
import 'package:schmitt/src/features/services/domain/usercases/get_companies.dart';
import 'package:schmitt/src/features/services/domain/usercases/get_reviews.dart';
import 'package:schmitt/src/features/services/domain/usercases/show_car.dart';
import 'package:schmitt/src/features/services/domain/usercases/show_service_use_case.dart';
import 'package:schmitt/src/features/services/domain/usercases/update_address.dart';
import 'package:schmitt/src/features/services/domain/usercases/update_car.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';

void initPackages() {
  sl.registerLazySingleton<PackageRemoteDataSourceImpl>(
    () => PackageRemoteDataSourceImpl(dio: sl<DioHelper>()
    ),
  );
  sl.registerLazySingleton(
    () => PackageRepositoryImpl(
      networkInfo: sl<NetworkInfoImpl>(),
      remoteDataSource: sl<PackageRemoteDataSourceImpl>(),
      appPreferences: sl<AppPreferences>(),
    ),
  );

  // UseCase
 /* sl.registerLazySingleton(
      () => AddReviweUseCase(repository: sl<ServiceRepositoryImpl>()));*/

  // Bloc
 /* sl.registerFactory(
    () => ServiceCubit(

    ),
  );*/
}
