import 'package:ct_social/core/extension/theme_getter_extension.dart';
import 'package:ct_social/feature/cubit/post/post_cubit.dart';
import 'package:ct_social/feature/cubit/user/user_model_cubit.dart';
import 'package:ct_social/feature/view/login/login_view_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => UserModelCubit(),
            ),
            BlocProvider(
              create: (context) => PostCubit()..init(),
            ),
          ],
          child: MaterialApp(
            title: 'ct_social_media_app',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
              useMaterial3: true,
              appBarTheme: AppBarTheme(
                titleTextStyle: context.theme.textTheme.headlineMedium,
                scrolledUnderElevation: 0,
              ),
              textTheme: TextTheme(
                headlineLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                headlineMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                headlineSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300, color: Colors.grey),
                bodyMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                bodySmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300, color: Colors.black),
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp))),
                  minimumSize: WidgetStateProperty.all(Size(double.infinity, 6.h)),
                ),
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp))),
                  minimumSize: WidgetStateProperty.all(Size(double.infinity, 6.h)),
                ),
              ),
            ),
            home: const LoginViewProvider(),
          ),
        );
      },
    );
  }
}
