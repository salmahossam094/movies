import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/screens/tabs/home-tab/cubit/cubit.dart';
import 'package:movies/screens/tabs/home-tab/cubit/state.dart';
import 'package:movies/shared/styles/text_styles.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({super.key});

  static const String routeName = 'MovieDetails';
  List<String> overview = [];

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as num;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetHomeMovieLoadingState) {
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Center(child: CircularProgressIndicator())),
          );
        }
        if (state is GetHomeMovieErrorState) {
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text('Error'),
              content: Text('connection'),
            ),
          );
        }
        if (state is GetHomeMovieSuccessState) {
          HomeCubit.get(context).getMovieDetails(args);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(
              '',
              style: quick20White(),
            ),
            backgroundColor: Colors.black,
          ),
          body: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        );
      },
    );
  }
}
