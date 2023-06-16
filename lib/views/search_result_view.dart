import 'package:flutter/material.dart';
import 'package:play_with_rxdart/bloc/search_result.dart';
import 'package:play_with_rxdart/models/animal.dart';
import 'package:play_with_rxdart/models/person.dart';

class SearchResultView extends StatelessWidget {
  final Stream<SearchResult?> searchResult;
  const SearchResultView({super.key, required this.searchResult});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchResult?>(
        stream: searchResult,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            final result = snapShot.data;
            if (result is SearchResultHasError) {
              print("Error -> ${result.error.toString()}");
              return Text("Error -> ${result.error.toString()}");
            } else if (result is SearchResultLoading) {
              return const CircularProgressIndicator();
            } else if (result is SearchResultNoResult) {
              return const Text("Empty");
            } else if (result is SearchResultWithResults) {
              final results = result.results;
              return Expanded(
                child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final item = results[index];
                      final String title;
                      if (item is Animal) {
                        title = "Animal";
                      } else if (item is Person) {
                        title = "Person";
                      } else {
                        title = "UnKnown";
                      }
                      return ListTile(
                        title: Text(title),
                        subtitle: Text(item.toString()),
                      );
                    }),
              );
            } else {
              return const Text("UnKnown State");
            }
          } else {
            return const Text("Waiting ...");
          }
        });
  }
}
