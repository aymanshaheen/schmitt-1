import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/app_size.dart';
import 'package:schmitt/src/core/utils/styles_manager.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors_light.dart';

ThemeData getThemeDataLight() {
  return ThemeData(
    // main colors
    primaryColor: AppColorsLight.primary,
    disabledColor: AppColorsLight.grey1,
    scaffoldBackgroundColor: AppColorsLight.primary,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    canvasColor: AppColorsLight.white,
    fontFamily: 'Urbanist',
    colorScheme:  ColorScheme.light(
      background: Colors.white,
      primary: AppColorsLight.primary,
      
    ), // cardview theme
    cardTheme: CardTheme(
        color: AppColorsLight.white,
        shadowColor: AppColorsLight.grey,
        elevation: 2),
    // app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: false,
        color: AppColorsLight.primary,
        elevation: AppSize.s4,
        shadowColor: AppColorsLight.primary,
        titleTextStyle: getRegularStyle(
          color: AppColorsLight.black,
        )),
    cardColor: AppColorsLight.white,
    // button theme
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: AppColorsLight.grey1,
        buttonColor: AppColorsLight.primary,
        splashColor: AppColorsLight.primary),
    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                color: AppColorsLight.white, fontSize: FontSize.s17),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),

    textTheme: TextTheme(
        displayLarge: getSemiBoldStyle(
            color: AppColorsLight.black, fontSize: FontSize.s16),
        headlineLarge: getSemiBoldStyle(
            color: AppColorsLight.black, fontSize: FontSize.s16),
        headlineMedium: getRegularStyle(
            color: AppColorsLight.black, fontSize: FontSize.s14),
        titleMedium:
            getMediumStyle(color: AppColorsLight.black, fontSize: FontSize.s16),
        titleSmall: getRegularStyle(
            color: AppColorsLight.black, fontSize: FontSize.s16),
        bodyLarge: getRegularStyle(color: AppColorsLight.black),
        bodySmall: getRegularStyle(color: AppColorsLight.black),
        bodyMedium: getRegularStyle(
            color: AppColorsLight.black, fontSize: FontSize.s12),
        labelSmall:
            getBoldStyle(color: AppColorsLight.black, fontSize: FontSize.s12)),

    inputDecorationTheme: InputDecorationTheme(

        // hint style
        hintStyle:
            getRegularStyle(color: AppColorsLight.grey, fontSize: FontSize.s14),
        labelStyle:
            getMediumStyle(color: AppColorsLight.grey, fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: AppColorsLight.error),

        // enabled border style
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColorsLight.grey, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border style
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColorsLight.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border style
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColorsLight.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused border style
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColorsLight.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)))),
    // label style
  );
}
