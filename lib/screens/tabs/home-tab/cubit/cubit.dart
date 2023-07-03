import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/model/NewRelease.dart';
import 'package:movies/model/PopularModel.dart';
import 'package:movies/model/TopRated.dart';
import 'package:movies/screens/tabs/home-tab/cubit/state.dart';
import 'package:movies/screens/tabs/home-tab/repository/repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.baseRepository) : super(HomeInitState());
  List<Results> popular = [];
  List<NewRResults> newRe = [];
  List<ResultsTop> topRated = [];
  BaseRepository baseRepository;

  static HomeCubit get(context) => BlocProvider.of(context);

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
      emit(GetHomePopularSuccessState());
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
      emit(GetHomeNewSuccessState());
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
      emit(GetHomeTopSuccessState());
    }).catchError((e) {
      emit(GetHomeTopErrorState(e));
    });
  }
}
