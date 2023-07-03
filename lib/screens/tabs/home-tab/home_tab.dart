import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/screens/tabs/home-tab/cubit/cubit.dart';
import 'package:movies/screens/tabs/home-tab/cubit/state.dart';
import 'package:movies/screens/tabs/home-tab/repository/dto/remote.dart';
import 'package:movies/screens/widgets/popular_widget.dart';
import 'package:movies/screens/widgets/upcoming_widget.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocProvider(
          create: (context) => HomeCubit(RemoteRepo())
            ..getPopularMovies()
            ..getNewReleasesMovies(),
          child: BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
            if (state is GetHomePopularLoadingState ||
                state is GetHomeNewLoadingState) {
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
          }, builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HomeCubit.get(context).popular.isEmpty &&
                        HomeCubit.get(context).newRe.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          PopularWidget(),
                          SizedBox(
                            height: 24.h,
                          ),
                          UpComing(),
                        ],
                      )
              ],
            );
          }),
        ),
      ],
    );
  }
}
