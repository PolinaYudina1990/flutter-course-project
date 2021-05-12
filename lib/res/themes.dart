import 'package:flutter/material.dart';
import 'package:places/res/text_styles.dart';
import 'colors.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lmBackgroundColor,
  dividerColor: lmDividerColor,
  backgroundColor: lmboxDescription,
  iconTheme: IconThemeData(color: lmIconColor),
  tabBarTheme: TabBarTheme(
    labelColor: lmBackgroundColor,
    unselectedLabelColor: lmTabBarUnselected,
    indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(30), color: lmTabBarSelected),
  ),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: buttonColor),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: lmBackgroundColor,
    selectedItemColor: primaryColor2,
    unselectedItemColor: primaryColor2,
  ),
  textTheme: TextTheme(
    headline2: textMedbold.copyWith(color: lmheadline2Color),
    headline3: titleText1.copyWith(color: lmheadline3Color),
    headline4: titleText2.copyWith(color: lmheadline4Color),
    headline5: textReg16bold.copyWith(color: lmheadline5Color),
    subtitle1: textReg15bold.copyWith(color: lmsubtitle1Color),
    subtitle2: textReg15.copyWith(color: lmsubtitle2Color),
    bodyText1: textReg15.copyWith(color: lmBody1Color),
    bodyText2: textReg14.copyWith(color: lmBody2Color),
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: buttonColor,
    inactiveTrackColor: planIcon,
    thumbColor: primaryColor,
    overlayColor: planIcon,
    overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
    trackHeight: 1,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: dmBackgroundColor,
  backgroundColor: dmBoxDescription,
  dividerColor: dmDividerColor,
  canvasColor: dmBackgroundColor,
  tabBarTheme: TabBarTheme(
    labelColor: dmBackgroundColor,
    unselectedLabelColor: dmTabBarUnselected,
    indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(30), color: dmTabBarSelected),
  ),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: buttonColor),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: dmColorPrimary,
    selectedItemColor: primaryColor,
    unselectedItemColor: primaryColor,
  ),
  textTheme: TextTheme(
    headline2: textMedbold.copyWith(color: dmheadline2Color),
    headline3: titleText1.copyWith(color: dmheadline3Color),
    headline4: titleText2.copyWith(color: dmheadline4Color),
    headline5: textReg16bold.copyWith(color: dmheadline5Color),
    subtitle1: textReg15bold.copyWith(color: dmsubtitle1Color),
    subtitle2: textReg15.copyWith(color: dmsubtitle2Color),
    bodyText1: textReg15.copyWith(color: dmBody1Color),
    bodyText2: textReg14.copyWith(color: dmBody2Color),
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: buttonColor,
    inactiveTrackColor: planIcon,
    thumbColor: primaryColor,
    overlayColor: planIcon,
    overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
    trackHeight: 1,
  ),
);
