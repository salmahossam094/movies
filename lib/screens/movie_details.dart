import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movies/screens/tabs/home-tab/cubit/state.dart';
import 'package:movies/screens/widgets/movie-widget.dart';
import 'package:movies/shared/styles/text_styles.dart';

import '../shared/styles/app_colors.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({super.key});

  static const String routeName = 'MovieDetails';
  List<String> overview = [];

  @override
  Widget build(BuildContext context) {


    return BlocConsumer(
      listener: (context, state) {
        if (state is GetHomeMovieLoadingState) {
          showDialog(
            context: context,
            builder: (context) =>
            const AlertDialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Center(child: CircularProgressIndicator())),
          );
        }
        if (state is GetHomeMovieErrorState) {
          showDialog(
            context: context,
            builder: (context) =>
            const AlertDialog(
              title: Text('Error'),
              content: Text('connection'),
            ),
          );
        }
        if(state is GetHomeMovieSuccessState){

        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(
             ' args.title' ?? '',
              style: quick20White(),
            ),
            backgroundColor: Colors.black,
          ),
          body: Column(
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
                            'https://image.tmdb.org/t/p/original${'args.backdropPath'}',
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
                 ' args.title' ?? '',
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
                 ' args.releaseDate' ?? '',
                  style: roboto8gray()
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
              ),
              SizedBox(
                height: 19.h,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                color: AppColor.primary,
                child: Row(
                  children: [
                    SizedBox(child: MovieWidget('args.posterPath' ?? '')),
                    SizedBox(
                      width: 11.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < overview.length; i++)
                            Text(
                              overview[i].trim(),
                              maxLines: 1,
                              style: poppins15White().copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w100,
                                overflow: TextOverflow.ellipsis,
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
                                '${'args.voteAverage'}',
                                style: poppins15White(),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },);
  }
}
