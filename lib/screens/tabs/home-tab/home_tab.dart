import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/screens/tabs/home-tab/cubit/cubit.dart';
import 'package:movies/screens/tabs/home-tab/cubit/state.dart';
import 'package:movies/screens/tabs/home-tab/repository/dto/remote.dart';
import 'package:movies/screens/tabs/home-tab/widgets/popular_widget.dart';
import 'package:movies/screens/tabs/home-tab/widgets/top_rated.dart';
import 'package:movies/screens/tabs/home-tab/widgets/upcoming_widget.dart';

import '../../../shared/styles/app_colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocProvider(
            create: (context) => HomeCubit(RemoteRepo())
              ..getPopularMovies()
              ..getNewReleasesMovies()
              ..getTopMovies(),
            child:
                BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
              if (state is GetHomePopularLoadingState ||
                  state is GetHomeNewLoadingState ||
                  state is GetHomeMovieLoadingState) {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      title: Center(child: CircularProgressIndicator())),
                );
              }
              if (state is GetHomePopularSuccessState) {}
              if (state is GetHomePopularErrorState) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.error),
                  ),
                );
              }
              if (state is GetHomePopularErrorConnectionState) {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text('Error'),
                    content: Text('connection'),
                  ),
                );
              }
              if (state is GetHomeNewErrorState) {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text('Error'),
                    content: Text('connection'),
                  ),
                );
              }
              if (state is GetHomeNewSuccessState) {}
              if (state is GetHomeMovieErrorState) {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text('Error'),
                    content: Text('connection'),
                  ),
                );
              }
              if (state is GetHomeMovieSuccessState) {}
            }, builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      HomeCubit.get(context).popular.isEmpty
                          ? SizedBox(
                              height: 200.h,
                              child: const Center(
                                  child: CircularProgressIndicator(
                                color: AppColor.secondary,
                              )),
                            )
                          : const PopularWidget(),
                      SizedBox(
                        height: 24.h,
                      ),
                      HomeCubit.get(context).newRe.isEmpty
                          ? SizedBox(
                              height: 200.h,
                              child: const Center(
                                  child: CircularProgressIndicator(
                                color: AppColor.secondary,
                              )),
                            )
                          : const UpComing(),
                      SizedBox(
                        height: 30.h,
                      ),
                      HomeCubit.get(context).topRated.isEmpty
                          ? SizedBox(
                              height: 200.h,
                              child: const Center(
                                  child: CircularProgressIndicator(
                                color: AppColor.secondary,
                              )),
                            )
                          : Container(
                              color: AppColor.primary,
                              padding: const EdgeInsets.all(8),
                              child: const TopRated()),
                    ],
                  )
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
