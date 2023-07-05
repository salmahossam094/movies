import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/shared/styles/app_colors.dart';

class MovieWidget extends StatelessWidget {
  String imageName;

  MovieWidget(this.imageName, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          CachedNetworkImage(
            height: 199.h,
            width: 129.w,
            fit: BoxFit.cover,
            imageUrl: 'https://image.tmdb.org/t/p/original$imageName',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                color: AppColor.secondary,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.bookmark_add,
              color: AppColor.grey,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
