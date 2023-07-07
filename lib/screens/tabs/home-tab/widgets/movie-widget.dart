import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/firebase/firebase_functions.dart';
import 'package:movies/shared/styles/app_colors.dart';

class MovieWidget extends StatefulWidget {
  String imageName;
  Function addToWatch;
  String id;

  MovieWidget(this.imageName, this.addToWatch, this.id, {super.key});

  @override
  State<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {
  bool isAdded = false;

  bool getMovieList() {
    FirebaseFunctions.searchMovieById(widget.id).then((value) {
      isAdded = value;
      setState(() {});
    });
    return isAdded;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          CachedNetworkImage(
            height: 199.h,
            width: 129.w,
            fit: BoxFit.cover,
            imageUrl: widget.imageName.isEmpty
                ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPple0XLVI1C5Qk6WZRtHEvgc8Ns7_CW09qeC3IlzUIw&s'
                : 'https://image.tmdb.org/t/p/original${widget.imageName}',
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
            onPressed: () {
              widget.addToWatch();
              isAdded = !isAdded;
              setState(() {});
            },
            icon: getMovieList()
                ? Icon(
                    Icons.bookmark_added,
                    color: AppColor.secondary,
                    size: 30,
                  )
                : Icon(
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
