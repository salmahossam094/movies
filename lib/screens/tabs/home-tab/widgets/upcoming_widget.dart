import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                        Navigator.pushNamed(
                          context,
                          MovieDetails.routeName,
                          arguments: HomeCubit.get(context).newRe[index].id
                        );
                      },
                      child: MovieWidget(
                          HomeCubit.get(context).newRe[index].posterPath!),
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
