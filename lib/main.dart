import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/bloc_observer.dart';
import 'package:movies/layout/home_layout.dart';
import 'package:movies/screens/movie_details/movie_details.dart';
import 'package:movies/screens/tabs/browse/movies_with_categories.dart';
import 'package:movies/shared/styles/my_theme.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 892),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: HomeLayout.routeName,
            routes: {
              HomeLayout.routeName: (context) => const HomeLayout(),
              MovieDetails.routeName: (context) => MovieDetails(),
              MovieWithCategoriesScreen.routeName: (context) =>
                  MovieWithCategoriesScreen()
            },
            theme: MyThemeData.lightTheme,
          );
        }
    );
  }
}
