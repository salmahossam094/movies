import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/screens/tabs/search_tab/cubit/cubit.dart';
import 'package:movies/screens/tabs/search_tab/cubit/states.dart';
import 'package:movies/screens/tabs/search_tab/repository/dto/remote.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(RemoteRepoSearch())
        ..search(SearchCubit.get(context).query),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          if (state is SearchLoadingState) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: Center(child: CircularProgressIndicator())),
            );
          }
          if (state is SearchSuccessState) {}
          if (state is SearchErrorState) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              
            ],
          );
        }),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
