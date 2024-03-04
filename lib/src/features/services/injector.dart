import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/network/network_info.dart';
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
  sl.registerLazySingleton(
      () => GetAdressesUseCase(repository: sl<ServiceRepositoryImpl>()));
  sl.registerLazySingleton(
      () => CreateAdressesUseCase(repository: sl<ServiceRepositoryImpl>()));
  sl.registerLazySingleton(
      () => ShowServicesUseCase(repository: sl<ServiceRepositoryImpl>()));
  sl.registerLazySingleton(
      () => CreateOrderUseCase(repository: sl<ServiceRepositoryImpl>()));
  sl.registerLazySingleton(
      () => CreateCarUseCase(repository: sl<ServiceRepositoryImpl>()));
  sl.registerLazySingleton(
      () => GetCarsUseCase(repository: sl<ServiceRepositoryImpl>()));
  sl.registerLazySingleton(
      () => GetColorsUseCase(repository: sl<ServiceRepositoryImpl>()));
  sl.registerLazySingleton(
      () => GetCompaniesUseCase(repository: sl<ServiceRepositoryImpl>()));
  sl.registerLazySingleton(
      () => ShowCarUseCase(repository: sl<ServiceRepositoryImpl>()));
  sl.registerLazySingleton(
      () => UpdateCarUseCase(repository: sl<ServiceRepositoryImpl>()));
  sl.registerLazySingleton(
      () => DeleteCarUseCase(repository: sl<ServiceRepositoryImpl>()));
  sl.registerLazySingleton(
      () => DeleteAddressUseCase(repository: sl<ServiceRepositoryImpl>()));
  sl.registerLazySingleton(
      () => UpdateAddressUseCase(repository: sl<ServiceRepositoryImpl>()));
  // Bloc
  sl.registerFactory(
    () => ServiceCubit(
      addReviweUseCase: sl<AddReviweUseCase>(),
      getReviwesUseCase: sl<GetReviwesUseCase>(),
      createCarUseCase: sl<CreateCarUseCase>(),
      deleteCarUseCase: sl<DeleteCarUseCase>(),
      deleteAddressUseCase: sl<DeleteAddressUseCase>(),
      updateAddressUseCase: sl<UpdateAddressUseCase>(),
      showCarUseCase: sl<ShowCarUseCase>(),
      updateCarUseCase: sl<UpdateCarUseCase>(),
      getCompaniesUseCase: sl<GetCompaniesUseCase>(),
      getColorsUseCase: sl<GetColorsUseCase>(),
      getCarsUseCase: sl<GetCarsUseCase>(),
      getServicesUseCase: sl<ShowServicesUseCase>(),
      createOrderUseCase: sl<CreateOrderUseCase>(),
      getAdressesUseCase: sl<GetAdressesUseCase>(),
      createAdressesUseCase: sl<CreateAdressesUseCase>(),
    ),
  );
}
