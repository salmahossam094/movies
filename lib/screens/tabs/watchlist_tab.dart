import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/firebase/firebase_functions.dart';
import 'package:movies/model/watchlist_model.dart';
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
      padding: EdgeInsets.symmetric(vertical: 75.5.h, horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Watchlist',
            style: quick20White().copyWith(fontSize: 22),
          ),
          SizedBox(
            height: 14.h,
          ),
          StreamBuilder(
            stream: FirebaseFunctions.getMoviesFormFire(),
            builder: (context, snapshot) {
              List<WatchListModel> movie =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              return Expanded(
                child: ListView.separated(
                  itemCount: movie.length,
                  itemBuilder: (context, index) => Row(
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
                          Text(
                            movie[index].title!,
                            style: quick20White().copyWith(
                                fontWeight: FontWeight.w100, fontSize: 14.sp),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            textScaleFactor: 0.81,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            movie[index].releaseDate!,
                            style: roboto8gray().copyWith(fontSize: 13.sp),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            movie[index].originalLanguage!,
                            style: roboto8gray().copyWith(fontSize: 13.sp),
                          )
                        ],
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            FirebaseFunctions.deleteMovie(
                                movie[index].id.toString());
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
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
