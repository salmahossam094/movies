import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/layout/bloc/states.dart';
import 'package:movies/screens/tabs/browse/browse_tab.dart';
import 'package:movies/screens/tabs/home-tab/home_tab.dart';
import 'package:movies/screens/tabs/search_tab/search_tab.dart';
import 'package:movies/screens/tabs/watchlist_tab.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(HomeLayoutInitState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);
  List<Widget> tabs = [const HomeTab(), const SearchTab(), const BrowseTab(), const WatchListTab()];

int selectedIndex=0;
  changeSelectedIndex(value) {
    selectedIndex=value;
    emit(HomeLayoutNavigationChangeState());
  }
}
