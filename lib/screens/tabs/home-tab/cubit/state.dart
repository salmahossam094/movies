abstract class HomeState {}

class HomeInitState extends HomeState {}

class GetHomePopularLoadingState extends HomeState {}

class GetHomePopularSuccessState extends HomeState {}

class GetHomePopularErrorConnectionState extends HomeState {}

class GetHomePopularErrorState extends HomeState {
  var error;

  GetHomePopularErrorState(this.error);
}

class GetHomeNewLoadingState extends HomeState {}

class GetHomeNewSuccessState extends HomeState {}

class GetHomeNewErrorState extends HomeState {
  var error;

  GetHomeNewErrorState(this.error);
}

class GetHomeTopLoadingState extends HomeState {}

class GetHomeTopSuccessState extends HomeState {}

class GetHomeTopErrorState extends HomeState {
  var error;

  GetHomeTopErrorState(this.error);
}

class GetHomeSimilarLoadingState extends HomeState {}

class GetHomeSimilarSuccessState extends HomeState {}

class GetHomeSimilarErrorState extends HomeState {
  String error;

  GetHomeSimilarErrorState(this.error);
}

class GetHomeMovieLoadingState extends HomeState {}

class GetHomeMovieSuccessState extends HomeState {}

class GetHomeMovieErrorState extends HomeState {
  String error;

  GetHomeMovieErrorState(this.error);
}
