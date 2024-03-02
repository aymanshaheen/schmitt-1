import 'package:flutter/services.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/langauge_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'bloc_observer.dart';
import 'src/container_injector.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'src/my_app.dart';
import 'package:camera/camera.dart';

typedef AppBuilder = Future<Widget> Function();
bool isDark = sl<AppPreferences>().getData(key: 'isDark') ?? false;
Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  AppConstants.cameras = await availableCameras();
  initApp();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  runApp(await builder());
}
//
void main() {
  bootstrap(
    () async {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.dark,
      ));

      return EasyLocalization(
          supportedLocales: const [arabiclocale, englishlocale],
          path: assetPath,
          child: Phoenix(child: MyApp(isDark)));
    },
  );
}
