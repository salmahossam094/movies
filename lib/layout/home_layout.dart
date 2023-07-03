import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/layout/bloc/cubit.dart';
import 'package:movies/layout/bloc/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  static const String routeName = "home-layout";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeLayoutCubit(),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
              child: Scaffold(
            backgroundColor: Colors.black,
            body: HomeLayoutCubit.get(context)
                .tabs[HomeLayoutCubit.get(context).selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
                onTap: (value) {
                  HomeLayoutCubit.get(context).changeSelectedIndex(value);
                },
                currentIndex: HomeLayoutCubit.get(context).selectedIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        size: 26,
                      ),
                      label: "Home"),
                  const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.search,
                        size: 26,
                      ),
                      label: "Search"),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                          HomeLayoutCubit.get(context).selectedIndex == 2
                              ? 'assets/icons/sel-bro.png'
                              : 'assets/icons/browse_icon.png'),
                      label: "Browse"),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                          HomeLayoutCubit.get(context).selectedIndex == 3
                              ? 'assets/icons/sel-watch.png'
                              : 'assets/icons/watchlist_icon.png'),
                      label: "WatchList"),
                ]),
          ));
        },
      ),
    );
  }
}
