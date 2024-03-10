import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/network/network_info.dart';
import 'package:schmitt/src/features/orders/data/data_sources/user_remote_data_source_impl.dart';
import 'package:schmitt/src/features/orders/data/repositories/home_repository_impl.dart';
import 'package:schmitt/src/features/orders/domain/use_cases/cancle_orders.dart';
import 'package:schmitt/src/features/orders/domain/use_cases/get_orders.dart';
import 'package:schmitt/src/features/orders/domain/use_cases/update_order.dart';
import 'package:schmitt/src/features/orders/presentation/cubit/booking_cubit.dart';

void initBooking() {
  sl.registerLazySingleton<OrderDataSourceImpl>(
    () => OrderDataSourceImpl(
      dio: sl<DioHelper>(),
    ),
  );
  sl.registerLazySingleton(
    () => OrderRepositoryImpl(
      networkInfo: sl<NetworkInfoImpl>(),
      remoteDataSource: sl<OrderDataSourceImpl>(),
    ),
  );
  sl.registerLazySingleton(
    () => GetOrdersUseCase(
      repository: sl<OrderRepositoryImpl>(),
    ),
  );
  sl.registerLazySingleton(
    () => CancleOrdersUseCase(
      repository: sl<OrderRepositoryImpl>(),
    ),
  );
  sl.registerLazySingleton(
    () => UpdateOrdersUseCase(
      repository: sl<OrderRepositoryImpl>(),
    ),
  );

  sl.registerFactory(
    () => BookingCubit(
      getOrdersUseCase: sl<GetOrdersUseCase>(),
      cancleOrdersUseCase: sl<CancleOrdersUseCase>(),
      updateOrdersUseCase: sl<UpdateOrdersUseCase>(),
    ),
  );
}
