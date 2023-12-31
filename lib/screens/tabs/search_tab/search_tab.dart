import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/screens/movie_details/movie_details.dart';
import 'package:movies/shared/styles/app_colors.dart';

import '../../../api/api_manager.dart';
import '../../../model/SearchModel.dart';
import '../../../shared/styles/text_styles.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  var searchController = TextEditingController();
  String movieName = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.search,
            onChanged: (value) {
              setState(() {
                movieName = value;
              });
            },

            // onTap: () =>
            //     showSearch(context: context, delegate: MySearchDelegate()),
            controller: searchController,
            style: poppins15White(),
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search_sharp,
                  color: Colors.white,
                  size: 30,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r).w,
                    borderSide: const BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r).w,
                    borderSide: const BorderSide(color: Colors.white)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r).w,
                    borderSide: const BorderSide(color: AppColor.primary))),
          ),
          SizedBox(
            height: 30.h,
          ),
          FutureBuilder<SearchModel>(
            future: ApiManager.search(movieName),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Column(
                  children: [Text('error')],
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColor.secondary,
                ));
              }
              if (snapshot.data!.totalResults == 0) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.local_movies,
                        size: 100,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0).w,
                        child: Text(
                          'No movies Founded',
                          style: quick20White(),
                        ),
                      )
                    ],
                  ),
                );
              }
              var result = snapshot.data?.results ?? [];
              return Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ).w,
                    child: ListView.separated(
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, MovieDetails.routeName,
                              arguments: result[index].id),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                height: 95.h,
                                width: 135.w,
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original${result[index].backdropPath}',
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
                                        MediaQuery.of(context).size.width * .4,
                                    child: Text(
                                      result[index].title!,
                                      style: quick20White().copyWith(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 13.sp,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    result[index].releaseDate!,
                                    style:
                                        roboto8gray().copyWith(fontSize: 13.sp),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    result[index].originalLanguage!,
                                    style:
                                        roboto8gray().copyWith(fontSize: 13.sp),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(
                          indent: 25,
                          endIndent: 25,
                          color: AppColor.secondary,
                          thickness: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
    // return BlocProvider(
    //   create: (context) => SearchCubit(RemoteRepoSearch())
    //     ..search(SearchCubit.get(context).query),
    //   child:
    //       BlocConsumer<SearchCubit, SearchStates>(listener: (context, state) {
    //     if (state is SearchLoadingState) {
    //       showDialog(
    //         context: context,
    //         builder: (context) => const AlertDialog(
    //             elevation: 0,
    //             backgroundColor: Colors.transparent,
    //             title: Center(child: CircularProgressIndicator())),
    //       );
    //     }
    //     if (state is SearchSuccessState) {}
    //     if (state is SearchErrorState) {
    //       Navigator.pop(context);
    //       showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           title: const Text('Error'),
    //           content: Text(state.error),
    //         ),
    //       );
    //     }
    //   }, builder: (context, state) {
    //     return Column(
    //       children: [SearchWidget(SearchCubit.get(context).query)],
    //     );
    //   }),
    // );
  }
}
