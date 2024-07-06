import 'package:ayna_task/core/constants/color_constants.dart';
import 'package:ayna_task/core/routes/routes.dart';
import 'package:ayna_task/core/constants/text_style_constants.dart';
import 'package:ayna_task/features/authentication/presentation/blocs/login/login_bloc.dart';
import 'package:ayna_task/features/authentication/presentation/blocs/sign_up/sign_up_bloc.dart';
import 'package:ayna_task/features/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:ayna_task/features/dashboard/presentation/blocs/dashboard_info/dashboard_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///[MyApp] is the entry point of the app.
///[MyApp] is a stateless widget which returns a [MaterialApp] widget.
///[MyApp] contains the theme configuration of the app.
///[MyApp] contains the [lightColorScheme] and [darkColorScheme] for the app.
///[MyApp] contains the [buttonThemeData] for the app.
///[MyApp] contains the [textTheme] for the app.
// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: ColorConstants.black,
    onPrimary: ColorConstants.black,
    secondary: ColorConstants.black,
    onSecondary: ColorConstants.white,
    error: ColorConstants.red,
    onError: ColorConstants.red,
    surface: ColorConstants.black,
    onSurface: ColorConstants.black,
  );

  ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: ColorConstants.white,
    onPrimary: ColorConstants.black,
    secondary: ColorConstants.white,
    onSecondary: ColorConstants.black,
    error: ColorConstants.red,
    onError: ColorConstants.red,
    surface: ColorConstants.white,
    onSurface: ColorConstants.white,
  );

  ButtonThemeData buttonThemeData = const ButtonThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: ColorConstants.white,
      onPrimary: ColorConstants.white,
      secondary: ColorConstants.white,
      onSecondary: ColorConstants.white,
      error: ColorConstants.white,
      onError: ColorConstants.white,
      surface: ColorConstants.white,
      onSurface: ColorConstants.white,
    ),
  );

  TextTheme textTheme = TextTheme(
    displayLarge: TextStyleConstants.displayLargeTextStyle,
    displaySmall: TextStyleConstants.displaySmallTextStyle,
    labelSmall: TextStyleConstants.labelSmallTextStyle,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => DashboardInfoBloc()),
        BlocProvider(create: (context) => ChatBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Ayna',
        theme: ThemeData(
          scaffoldBackgroundColor: ColorConstants.white,
          fontFamily: TextStyleConstants.fontFamily,
          useMaterial3: true,
          colorScheme: lightColorScheme,
          buttonTheme: buttonThemeData,
          textTheme: textTheme,
        ),
        darkTheme: ThemeData(
          fontFamily: TextStyleConstants.fontFamily,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1),
          useMaterial3: true,
          colorScheme: darkColorScheme,
          buttonTheme: buttonThemeData,
          textTheme: textTheme,
        ),
        themeMode: MediaQuery.platformBrightnessOf(context) == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light,
        routerConfig: Routes.router,
      ),
    );
  }
}
