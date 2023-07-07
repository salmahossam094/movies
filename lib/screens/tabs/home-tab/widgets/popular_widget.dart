import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/firebase/firebase_functions.dart';
import 'package:movies/model/watchlist_model.dart';
import 'package:movies/screens/movie_details/movie_details.dart';

import '../../../../shared/styles/app_colors.dart';
import '../cubit/cubit.dart';
import 'movie-widget.dart';

class PopularWidget extends StatelessWidget {
  const PopularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
          itemCount: HomeCubit.get(context).popular.length,
          itemBuilder: (context, index, realIndex) {
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 240.h,
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, MovieDetails.routeName,
                          arguments: HomeCubit.get(context).popular[index].id);
                    },
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r)),
                      color: AppColor.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: CachedNetworkImage(
                            height: 450.h,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            imageUrl:
                                'https://image.tmdb.org/t/p/original${HomeCubit.get(context).popular[index].backdropPath}',
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.play_circle,
                  size: 60,
                  color: Colors.grey.shade100,
                ),
                Positioned(
                  bottom: 2,
                  top: 110,
                  left: 25,
                  child: Row(
                    children: [
                      MovieWidget(
                          HomeCubit.get(context).popular[index].posterPath!,
                          () {
                        WatchListModel movie = WatchListModel(
                            voteCount:
                                HomeCubit.get(context).popular[index].voteCount,
                            voteAverage: HomeCubit.get(context)
                                .popular[index]
                                .voteAverage,
                            video: HomeCubit.get(context).popular[index].video,
                            releaseDate: HomeCubit.get(context)
                                .popular[index]
                                .releaseDate,
                            posterPath: HomeCubit.get(context)
                                .popular[index]
                                .posterPath,
                            popularity: HomeCubit.get(context)
                                .popular[index]
                                .popularity,
                            overview:
                                HomeCubit.get(context).popular[index].overview,
                            originalTitle: HomeCubit.get(context)
                                .popular[index]
                                .originalTitle,
                            originalLanguage: HomeCubit.get(context)
                                .popular[index]
                                .originalLanguage,
                            backdropPath: HomeCubit.get(context)
                                .popular[index]
                                .backdropPath,
                            adult: HomeCubit.get(context).popular[index].adult,
                            title: HomeCubit.get(context).popular[index].title,
                            id: HomeCubit.get(context).popular[index].id);
                        FirebaseFunctions.addMovieToFire(movie);
                      },HomeCubit.get(context).popular[index].id.toString()),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  heightFactor: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(
                          HomeCubit.get(context).popular[index].title ?? '',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        HomeCubit.get(context).popular[index].releaseDate ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              ],
            );
          },
          options: CarouselOptions(
              viewportFraction: 1,
              height: 289.h,
              disableCenter: true,
              aspectRatio: 25,
              enlargeFactor: 20,
              autoPlay: true,
              scrollDirection: Axis.horizontal)),
    );
  }
}
