import 'package:flutter/material.dart';
import 'package:play_with_rxdart/bloc/api.dart';
import 'package:play_with_rxdart/bloc/search_bloc.dart';
import 'package:play_with_rxdart/views/search_result_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SearchBloc _searchBloc;
  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc(api: Api());
  }

  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your search term here ... ',
              ),
              onChanged: _searchBloc.search.add,
            ),
            const SizedBox(
              height: 10,
            ),
            SearchResultView(searchResult: _searchBloc.results),
          ],
        ),
      ),
    );
  }
}
