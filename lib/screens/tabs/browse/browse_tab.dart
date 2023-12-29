import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/screens/tabs/browse/cubit/cubit.dart';
import 'package:movies/screens/tabs/browse/cubit/states.dart';
import 'package:movies/screens/tabs/browse/movies_with_categories.dart';
import 'package:movies/screens/tabs/browse/repository/dto/remote.dart';
import 'package:movies/shared/styles/app_colors.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrowseCubit(BrowseRemoteRepo())..getCategories(),
      child: BlocConsumer<BrowseCubit, BrowseStates>(
        listener: (context, state) {
          if (state is BrowseLoadingState) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: Center(
                      child: CircularProgressIndicator(
                    color: AppColor.secondary,
                  ))),
            );
          }
          if (state is BrowseErrorState) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Error'),
                content: Text('connection'),
              ),
            );
          }
          if (state is BrowseSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) => BrowseCubit.get(context).categories.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColor.secondary,
              ))
            : Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: BrowseCubit.get(context).categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 4.9 / 5),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, MovieWithCategoriesScreen.routeName,
                              arguments:
                                  BrowseCubit.get(context).categories[index]),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset('assets/images/categories.png'),
                              Text(BrowseCubit.get(context)
                                      .categories[index]
                                      .name ??
                                  ''),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
