import 'package:movies/model/MovieDetailsModel.dart';
import '../../../../model/PopularModel.dart';
import '../../../../model/TopRated.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class GetHomePopularLoadingState extends HomeState {}

class GetHomePopularSuccessState extends HomeState {
  List<Results> result;

  GetHomePopularSuccessState(this.result);
}

class GetHomePopularErrorConnectionState extends HomeState {}

class GetHomePopularErrorState extends HomeState {
  String error;

  GetHomePopularErrorState(this.error);
}

class GetHomeNewLoadingState extends HomeState {}

class GetHomeNewSuccessState extends HomeState {
  List<Results> newRelease;

  GetHomeNewSuccessState(this.newRelease);
}

class GetHomeNewErrorState extends HomeState {
  String error;

  GetHomeNewErrorState(this.error);
}

class GetHomeTopLoadingState extends HomeState {}

class GetHomeTopSuccessState extends HomeState {
   List<ResultsTop> resultsTop;

  GetHomeTopSuccessState(this.resultsTop);
}

class GetHomeTopErrorState extends HomeState {
  String error;

  GetHomeTopErrorState(this.error);
}

class GetHomeSimilarLoadingState extends HomeState {}

class GetHomeSimilarSuccessState extends HomeState {}

class GetHomeSimilarErrorState extends HomeState {
  String error;

  GetHomeSimilarErrorState(this.error);
}

class GetHomeMovieLoadingState extends HomeState {

}

class GetHomeMovieSuccessState extends HomeState {
  MovieDetailsModel movieDetailsModel;

  GetHomeMovieSuccessState(this.movieDetailsModel);
}

class GetHomeMovieErrorState extends HomeState {
  String error;

  GetHomeMovieErrorState(this.error);
}
