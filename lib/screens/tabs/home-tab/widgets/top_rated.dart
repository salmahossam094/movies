import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/firebase/firebase_functions.dart';
import 'package:movies/shared/styles/app_colors.dart';

import '../../../../model/watchlist_model.dart';
import '../../../../shared/styles/text_styles.dart';
import '../../../movie_details/movie_details.dart';
import '../cubit/cubit.dart';
import 'movie-widget.dart';

class TopRated extends StatelessWidget {
  const TopRated({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primary,
      padding: const EdgeInsets.all(8).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0).r,
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Top Rated',
                  style: quick20White(),
                )),
          ),
          SizedBox(
            height: 12.h,
          ),
          CarouselSlider.builder(
              itemCount: HomeCubit.get(context).topRated.length,
              itemBuilder: (context, index, realIndex) {
                return SizedBox(
                  width: 300.w,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10).w),
                    color: const Color(0xFF343534),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, MovieDetails.routeName,
                                      arguments: HomeCubit.get(context)
                                          .topRated[index]
                                          .id);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18).w
                                  ,
                                  child: MovieWidget(
                                      HomeCubit.get(context)
                                          .topRated[index]
                                          .posterPath!, () {
                                    WatchListModel movie = WatchListModel(
                                        title: HomeCubit.get(context)
                                            .topRated[index]
                                            .title,
                                        adult: HomeCubit.get(context)
                                            .topRated[index]
                                            .adult,
                                        backdropPath: HomeCubit.get(context)
                                            .topRated[index]
                                            .backdropPath,
                                        originalLanguage: HomeCubit.get(context)
                                            .topRated[index]
                                            .originalLanguage,
                                        originalTitle: HomeCubit.get(context)
                                            .topRated[index]
                                            .originalTitle,
                                        overview: HomeCubit.get(context)
                                            .topRated[index]
                                            .overview,
                                        popularity: HomeCubit.get(context)
                                            .topRated[index]
                                            .popularity,
                                        posterPath: HomeCubit.get(context)
                                            .topRated[index]
                                            .posterPath,
                                        releaseDate: HomeCubit.get(context)
                                            .topRated[index]
                                            .releaseDate,
                                        video: HomeCubit.get(context)
                                            .topRated[index]
                                            .video,
                                        voteAverage: HomeCubit.get(context)
                                            .topRated[index]
                                            .voteAverage,
                                        voteCount: HomeCubit.get(context)
                                            .topRated[index]
                                            .voteCount,
                                        id: HomeCubit.get(context)
                                            .topRated[index]
                                            .id);
                                    FirebaseFunctions.addMovieToFire(movie);

                                  },
                                      HomeCubit.get(context)
                                          .topRated[index]
                                          .id
                                          .toString()),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star_rate,
                              size: 28.sp,
                              color: AppColor.secondary,
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                            Text(
                              ' ${HomeCubit.get(context).topRated[index].voteAverage}',
                              style: poppins15White().copyWith(fontSize: 10.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0).r,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              HomeCubit.get(context).topRated[index].title!,
                              style: poppins15White().copyWith(
                                fontSize: 10.sp,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0,top: 5.0).r,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              HomeCubit.get(context).topRated[index].releaseDate!,
                              style: roboto8gray().copyWith(fontSize: 10.sp),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        )
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                  viewportFraction: 0.37,
                  height: 310.h,
                  disableCenter: false,
                  aspectRatio: 20,
                  enlargeFactor: 22,
                  scrollDirection: Axis.horizontal)),
        ],
      ),
    );
  }
}
