import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:schmitt/src/features/auth/auth_injector.dart';
import 'package:schmitt/src/features/home/injector.dart';
import 'package:schmitt/src/features/inbox/chat_injection_container.dart';
import 'package:schmitt/src/features/packages/injector.dart';
import 'package:schmitt/src/features/services/injector.dart';
import 'package:schmitt/src/features/technician_app/home/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/dio_helper.dart';
import 'core/api/interceptors.dart';
import 'core/network/network_info.dart';

final sl = GetIt.instance;

void initApp() {
  initCore();
  initAuth();
  initHome();
  initChat();
  initServices();
  initTech();
  initPackages();
}

Future<void> initCore() async {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<AppInterceptors>(() => AppInterceptors());

  final sharedPrefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));

  sl.registerLazySingleton<LogInterceptor>(
    () => LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ),
  );
  sl.registerLazySingleton<DioHelper>(() => DioHelper(dio: sl<Dio>()));
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );
  sl.registerLazySingleton<NetworkInfoImpl>(
    () => NetworkInfoImpl(connectionChecker: sl<InternetConnectionChecker>()),
  );
}
