import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/firebase/firebase_functions.dart';
import 'package:movies/model/watchlist_model.dart';
import 'package:movies/shared/styles/app_colors.dart';

import '../../../../shared/styles/text_styles.dart';
import '../../../movie_details/movie_details.dart';
import '../cubit/cubit.dart';
import 'movie-widget.dart';

class UpComing extends StatelessWidget {
  const UpComing({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primary,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Up Coming',
                  style: quick20White(),
                )),
          ),
          SizedBox(
            height: 12.h,
          ),
          CarouselSlider.builder(
              itemCount: HomeCubit.get(context).newRe.length,
              itemBuilder: (context, index, realIndex) {
                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, MovieDetails.routeName,
                            arguments: HomeCubit.get(context).newRe[index].id);
                      },
                      child: MovieWidget(
                          HomeCubit.get(context).newRe[index].posterPath!, () {
                        WatchListModel movie = WatchListModel(
                            id: HomeCubit.get(context).newRe[index].id,
                            voteCount:
                                HomeCubit.get(context).newRe[index].voteCount,
                            voteAverage:
                                HomeCubit.get(context).newRe[index].voteAverage,
                            video: HomeCubit.get(context).newRe[index].video,
                            releaseDate:
                                HomeCubit.get(context).newRe[index].releaseDate,
                            posterPath:
                                HomeCubit.get(context).newRe[index].posterPath,
                            popularity:
                                HomeCubit.get(context).newRe[index].popularity,
                            overview:
                                HomeCubit.get(context).newRe[index].overview,
                            originalTitle: HomeCubit.get(context)
                                .newRe[index]
                                .originalTitle,
                            originalLanguage: HomeCubit.get(context)
                                .newRe[index]
                                .originalLanguage,
                            backdropPath: HomeCubit.get(context)
                                .newRe[index]
                                .backdropPath,
                            adult: HomeCubit.get(context).newRe[index].adult,
                            title: HomeCubit.get(context).newRe[index].title);
                        FirebaseFunctions.addMovieToFire(movie);
                      }, HomeCubit.get(context).newRe[index].id.toString()),
                    )
                  ],
                );
              },
              options: CarouselOptions(
                  viewportFraction: 0.32,
                  height: 250.h,
                  disableCenter: false,
                  aspectRatio: 20,
                  enlargeFactor: 22,
                  scrollDirection: Axis.horizontal)),
        ],
      ),
    );
  }
}
