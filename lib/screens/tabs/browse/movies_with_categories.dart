import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/model/BrowseModel.dart';
import 'package:movies/api/api_manager.dart';
import 'package:movies/screens/movie_details/movie_details.dart';
import 'package:movies/shared/styles/app_colors.dart';

import '../../../shared/styles/text_styles.dart';

class MovieWithCategoriesScreen extends StatelessWidget {
  MovieWithCategoriesScreen({super.key});

  static const String routeName = "MovieWithCat";

  @override
  Widget build(BuildContext context) {
    var cat = ModalRoute.of(context)!.settings.arguments as Genres;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          cat.name!,
          style: quick20White().copyWith(fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: ApiManager.getMoviesCat(cat.id!),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Column(
                  children: [Text('error')],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColor.secondary,
                ));
              }
              var movies = snapshot.data!.results ?? [];
              print(movies.length);
              return Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, MovieDetails.routeName,
                                arguments: movies[index].id),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  height: 95.h,
                                  width: 135.w,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/original${movies[index].backdropPath}',
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                      color: AppColor.secondary,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movies[index].title!,
                                      style: quick20White().copyWith(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 14.sp),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      textScaleFactor: 0.81,
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      movies[index].releaseDate!,
                                      style: roboto8gray()
                                          .copyWith(fontSize: 13.sp),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      movies[index].originalLanguage!,
                                      style: roboto8gray()
                                          .copyWith(fontSize: 13.sp),
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
                                          width: 2.w,
                                        ),
                                        Text(
                                          '  ${movies[index].voteAverage}',
                                          style: poppins15White(),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            indent: 25,
                            endIndent: 25,
                            color: AppColor.secondary,
                            thickness: 2,
                          ),
                        ),
                    itemCount: movies.length),
              );
            },
          ),
        ],
      ),
    );
  }
}
