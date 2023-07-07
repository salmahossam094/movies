// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/api/api_manager.dart';
import 'package:movies/firebase/firebase_functions.dart';
import 'package:movies/model/movie_details_models/MovieDetailsModel.dart';
import 'package:movies/model/watchlist_model.dart';
import 'package:movies/screens/movie_details/similar.dart';
import 'package:movies/screens/tabs/home-tab/widgets/movie-widget.dart';
import 'package:movies/shared/styles/app_colors.dart';

import '../../shared/styles/text_styles.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({super.key});

  static const String routeName = 'MovieDetails';
  List<String> overview = [];

  @override
  Widget build(BuildContext context) {
    var movieId = ModalRoute.of(context)!.settings.arguments as num;

    return FutureBuilder<MovieDetailsModel>(
      future: ApiManager.movieDetails(movieId),
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
        var results = snapshot.data;

        overview = results!.overview!.split(',');
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(
              results.title!,
              style: quick20White(),
            ),
            backgroundColor: Colors.black,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 240.h,
                      width: double.infinity,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: AppColor.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              height: 450.h,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original${results.backdropPath}',
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
                    Icon(
                      Icons.play_circle,
                      size: 60,
                      color: Colors.grey.shade100,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    results.title ?? '',
                    style: quick20White()
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 30.sp),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    results.releaseDate ?? '',
                    style: roboto8gray()
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 12.sp),
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  height: 250.h,
                  width: double.infinity,
                  color: AppColor.primary,
                  child: Row(
                    children: [
                      SizedBox(
                          child: MovieWidget(results.posterPath ?? '', () {
                        WatchListModel movie = WatchListModel(
                            id: results.id,
                            title: results.title,
                            adult: results.adult,
                            backdropPath: results.backdropPath,
                            originalLanguage: results.originalLanguage,
                            originalTitle: results.originalTitle,
                            overview: results.overview,
                            popularity: results.popularity,
                            posterPath: results.posterPath,
                            releaseDate: results.releaseDate,
                            video: results.video,
                            voteAverage: results.voteAverage,
                            voteCount: results.voteCount);
                        FirebaseFunctions.addMovieToFire(movie);
                      },results.id.toString())),
                      SizedBox(
                        width: 11.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: GridView.builder(
                              itemCount: results.genres!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 5.w,
                                mainAxisSpacing: 3.h,
                              ),
                              itemBuilder: (BuildContext context, int index) =>
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.white70, width: 1)),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          results.genres![index].name!,
                                          style: roboto8gray().copyWith(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                      )),
                            )),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Text(
                                  results.overview ?? '',
                                  maxLines: 8,
                                  softWrap: true,
                                  style: poppins15White().copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w100,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 11.h,
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
                                  '  ${results.voteAverage}',
                                  style: poppins15White(),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
                MoreLikeThis(movieId),
              ],
            ),
          ),
        );
      },
    );
  }
}
