import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/firebase/firebase_functions.dart';
import 'package:movies/model/watchlist_model.dart';
import 'package:movies/screens/movie_details/movie_details.dart';
import 'package:movies/shared/styles/text_styles.dart';

import '../../shared/styles/app_colors.dart';

class WatchListTab extends StatefulWidget {
  const WatchListTab({super.key});

  @override
  State<WatchListTab> createState() => _WatchListTabState();
}

class _WatchListTabState extends State<WatchListTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 75.5.h, horizontal: 17.w).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Watchlist',
            style: quick20White().copyWith(fontSize: 22.sp),
          ),
          SizedBox(
            height: 14.h,
          ),
          StreamBuilder(
            stream: FirebaseFunctions.getMoviesFormFire(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColor.secondary,
                ));
              } else if (snapshot.hasError) {
                return Column(
                  children: [Text(snapshot.error.toString())],
                );
              }
              List<WatchListModel> movie =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              return movie.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200.h,
                          ),
                          const Icon(
                            Icons.local_movies,
                            size: 100,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'No movies ',
                              style: quick20White(),
                            ),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        itemCount: movie.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, MovieDetails.routeName,
                              arguments: movie[index].id),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                height: 95.h,
                                width: 135.w,
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original${movie[index].backdropPath}',
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
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
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      movie[index].title!,
                                      style: quick20White().copyWith(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 14.sp),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      textScaleFactor: 0.81,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    movie[index].releaseDate!,
                                    style:
                                        roboto8gray().copyWith(fontSize: 13.sp),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    movie[index].originalLanguage!,
                                    style:
                                        roboto8gray().copyWith(fontSize: 13.sp),
                                  )
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    FirebaseFunctions.deleteMovie(
                                        movie[index].id.toString());
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            Padding(
                          padding: const EdgeInsets.all(8.0).r,
                          child: const Divider(
                            indent: 25,
                            endIndent: 25,
                            color: AppColor.secondary,
                            thickness: 2,
                          ),
                        ),
                      ),
                    );
            },
          )
        ],
      ),
    );
  }
}
