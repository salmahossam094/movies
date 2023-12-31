import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/model/home_tab_models/NewRelease.dart';
import 'package:movies/model/home_tab_models/PopularModel.dart';
import 'package:movies/model/home_tab_models/TopRated.dart';
import 'package:movies/model/movie_details_models/MovieDetailsModel.dart';
import 'package:movies/screens/tabs/home-tab/cubit/state.dart';
import 'package:movies/screens/tabs/home-tab/repository/repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.baseRepository) : super(HomeInitState());
  List<Results> popular = [];
  List<Results> newRe = [];
  List<ResultsTop> topRated = [];
  MovieDetailsModel movieDetailsModel = MovieDetailsModel();
  bool isAdded = false;

  BaseRepository baseRepository;

  static HomeCubit get(context) => BlocProvider.of(context);

  void changeSelected() {
    isAdded = !isAdded;
    emit(PopularWatchlistChangedState());
  }

  void getPopularMovies() {
    emit(GetHomePopularLoadingState());
    baseRepository.getPopularMovies()?.then((value) {
      var responseJson = jsonDecode(value.body);
      PopularModel popularModel = PopularModel.fromJson(responseJson);
      if (popularModel.success == false) {
        emit(GetHomePopularErrorConnectionState());
        return;
      }
      popular = popularModel.results ?? [];
      emit(GetHomePopularSuccessState(popular));
    }).catchError((e) {
      emit(GetHomePopularErrorState(e));
    });
  }

  void getNewReleasesMovies() {
    emit(GetHomeNewLoadingState());
    baseRepository.getNewReleasesMovies()!.then((value) {
      var responseJson = jsonDecode(value.body);
      NewRelease newRelease = NewRelease.fromJson(responseJson);
      newRe = newRelease.results ?? [];
      emit(GetHomeNewSuccessState(newRe));
    }).catchError((e) {
      emit(GetHomeNewErrorState(e));
    });
  }

  void getTopMovies() {
    emit(GetHomeTopLoadingState());
    baseRepository.getTopMovies()!.then((value) {
      var responseJson = jsonDecode(value.body);
      TopRated topRatedM = TopRated.fromJson(responseJson);
      topRated = topRatedM.results ?? [];
      emit(GetHomeTopSuccessState(topRated));
    }).catchError((e) {
      emit(GetHomeTopErrorState(e));
    });
  }

  void getMovieDetails(num movieId) {
    emit(GetHomeMovieLoadingState());
    baseRepository.getMovieDetails(movieId)!.then((value) {
      var responseJson = jsonDecode(value.body);
      movieDetailsModel = MovieDetailsModel.fromJson(responseJson);
      emit(GetHomeMovieSuccessState(movieDetailsModel));
    }).catchError((e) {
      emit(GetHomeMovieErrorState(e));
    });
  }
}
