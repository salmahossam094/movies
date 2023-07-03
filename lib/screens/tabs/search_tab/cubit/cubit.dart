import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/screens/tabs/search_tab/cubit/states.dart';
import 'package:movies/screens/tabs/search_tab/repository/repo.dart';

import '../../../../model/SearchModel.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit(this.searchRepo) : super(SearchInitState());
  SearchRepo searchRepo;
  List<Results> searchResults = [];
  String query='';
 static SearchCubit get(context) => BlocProvider.of(context);

  void search(String query) {
    emit(SearchLoadingState());
    searchRepo.search(query).then((value) {
      var responseJson = jsonDecode(value.body);
      SearchModel searchModel = SearchModel.fromJson(responseJson);
      searchResults = searchModel.results ?? [];
      emit(SearchSuccessState());
    }).catchError((e) {
      emit(SearchErrorState(e));
    });
  }
}
