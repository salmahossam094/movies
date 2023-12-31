// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/api/api_manager.dart';
import 'package:movies/firebase/firebase_functions.dart';
import 'package:movies/model/watchlist_model.dart';
import 'package:movies/screens/movie_details/movie_details.dart';

import '../../shared/styles/app_colors.dart';
import '../../shared/styles/text_styles.dart';
import '../tabs/home-tab/widgets/movie-widget.dart';

class MoreLikeThis extends StatelessWidget {
  MoreLikeThis(this.movieId, {super.key});

  num movieId;

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        FutureBuilder(
          future: ApiManager.getSimilarMovies(movieId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColor.secondary,
              ));
            } else if (snapshot.hasError) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(snapshot.error.toString()),
              );
            }
            var similar = snapshot.data!.results ?? [];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'More Like This',
                      style: quick20White(),
                    )),
                SizedBox(
                  height: 12.h,
                ),
                CarouselSlider.builder(
                    itemCount: similar.length,
                    itemBuilder: (context, index, realIndex) {
                      return SizedBox(
                        width: 300.w,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10).w,
                          ),
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
                                            arguments: similar[index].id);
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(18).w,
                                        child: MovieWidget(
                                            similar[index].posterPath ?? '',
                                            () {
                                          WatchListModel movie = WatchListModel(
                                              id: similar[index].id,
                                              title: similar[index].title,
                                              adult: similar[index].adult,
                                              backdropPath:
                                                  similar[index].backdropPath,
                                              originalLanguage: similar[index]
                                                  .originalLanguage,
                                              originalTitle:
                                                  similar[index].originalTitle,
                                              overview: similar[index].overview,
                                              popularity:
                                                  similar[index].popularity,
                                              posterPath:
                                                  similar[index].posterPath,
                                              releaseDate:
                                                  similar[index].releaseDate,
                                              video: similar[index].video,
                                              voteAverage:
                                                  similar[index].voteAverage,
                                              voteCount:
                                                  similar[index].voteCount);
                                          FirebaseFunctions.addMovieToFire(
                                              movie);
                                        }, similar[index].id.toString()),
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
                                    ' ${similar[index].voteAverage}',
                                    style:
                                        poppins15White().copyWith(fontSize: 10.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0,bottom: 5.0).r,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    similar[index].title!,
                                    style: poppins15White().copyWith(
                                      fontSize: 10.sp,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0,).r,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    similar[index].releaseDate!,
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
            );
          },
        )
      ],
    );
  }
}
