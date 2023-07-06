abstract class BrowseStates {}

class BrowseInitState extends BrowseStates {}

class BrowseLoadingState extends BrowseStates {}

class BrowseSuccessState extends BrowseStates {}

class BrowseErrorState extends BrowseStates {
  String error;

  BrowseErrorState(this.error);
}

class getMovieCatLoadingState extends BrowseStates {}

class getMovieCatSuccessState extends BrowseStates {}

class getMovieCatErrorState extends BrowseStates {
  String error;

  getMovieCatErrorState(this.error);
}
