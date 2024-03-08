import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_themes/theme_data_dark.dart';
import 'package:schmitt/src/core/utils/theme/app_themes/theme_data_light.dart';
import 'package:schmitt/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/features/packages/presentation/cubit/package_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/cubit/tech_cubit.dart';
import 'config/app_route.dart';
import 'core/utils/app_strings.dart';

class MyApp extends StatefulWidget {
  bool isDark;
  MyApp(this.isDark, {super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = sl<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CredentialCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<ServiceCubit>(),
        ),
        BlocProvider(create:(context) => sl<PackageCubit>()),
        BlocProvider(create: (context) => sl<HomeCubit>()),
        BlocProvider(create: (context) => sl<TechCubit>()),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.splash,
            onGenerateRoute: AppRouter.routesGenerator,
            title: AppStrings.appName,
            theme: getThemeDataLight(),
            darkTheme: getThemeDataDark(),
            themeMode: HomeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
          );
        },
      ),
    );
  }
}
