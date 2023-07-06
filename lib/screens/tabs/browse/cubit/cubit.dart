import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/model/BrowseModel.dart';
import 'package:movies/screens/tabs/browse/cubit/states.dart';
import 'package:movies/screens/tabs/browse/model/MovieWithCategory.dart';
import 'package:movies/screens/tabs/browse/repository/repo.dart';

class BrowseCubit extends Cubit<BrowseStates> {
  BrowseCubit(this.browseRepo) : super(BrowseInitState());
  BrowseRepo browseRepo;
  List<Genres> categories = [];
  List<MovieCatResults> movies = [];

  static BrowseCubit get(context) => BlocProvider.of(context);

  void getCategories() {
    emit(BrowseLoadingState());
    browseRepo.getCategories().then((value) {
      emit(BrowseLoadingState());
      var responseJson = jsonDecode(value.body);
      BrowseModel browseModel = BrowseModel.fromJson(responseJson);
      categories = browseModel.genres ?? [];

      emit(BrowseSuccessState());
    }).catchError((e) {
      emit(BrowseErrorState(e.toString()));
    });
  }

// getMoviesCat(String cat) {
//   emit(getMovieCatLoadingState());
//   browseRepo.getMoviesWithCategories(cat).then((value) {
//     var responseJson = jsonDecode(value.body);
//     MovieWithCategory movieWithCategory =
//         MovieWithCategory.fromJson(responseJson);
//     movies = movieWithCategory.results ?? [];
//   }).catchError((e) {
//     emit(getMovieCatErrorState(e));
//   });
// }
}
