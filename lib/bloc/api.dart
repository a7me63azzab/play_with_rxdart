import 'dart:convert';
import 'dart:io';

import 'package:play_with_rxdart/models/animal.dart';
import 'package:play_with_rxdart/models/person.dart';
import 'package:play_with_rxdart/models/thing.dart';

typedef SearchTerm = String;

class Api {
  List<Animal>? _animals;
  List<Person>? _persons;

  Api();

  // http://127.0.0.1:5500/apis/persons.json
  //http://127.0.0.1:5500/apis/animals.json

  Future<List<Thing>> search(SearchTerm searchTerm) async {
    String term = searchTerm.trim().toLowerCase();
    // search in the cache
    final cacheResults = _extractThingUsingSearchTerm(term);
    if (cacheResults != null) {
      return cacheResults;
    }

    // we don't have the values cached, Lets call the APIs.
    // start by calling persons api.
    final persons =
        await _getJson('http://192.168.1.2:5500/apis/persons.json').then(
      (json) => json.map(
        (value) => Person.fromJson(value),
      ),
    );

    _persons = persons.toList();

    // start by calling animals api.
    final animals =
        await _getJson('http://192.168.1.2:5500/apis/animals.json').then(
      (json) => json.map(
        (value) => Animal.fromJson(value),
      ),
    );

    _animals = animals.toList();

    return _extractThingUsingSearchTerm(term) ?? [];
  }

  List<Thing>? _extractThingUsingSearchTerm(SearchTerm term) {
    final cachedAnimals = _animals;
    final cachedPersons = _persons;

    if (cachedAnimals != null && cachedPersons != null) {
      List<Thing> result = [];
      // go throgth animals
      for (final animal in cachedAnimals) {
        if (animal.name.trimmedContains(term) ||
            animal.type.name.trimmedContains(term)) {
          result.add(animal);
        }
      }

      // go throgth persons
      for (final person in cachedPersons) {
        if (person.name.trimmedContains(term) ||
            person.age.toString().trimmedContains(term)) {
          result.add(person);
        }
      }
      return result;
    } else {
      return null;
    }
  }

  Future<List<dynamic>> _getJson(String url) => HttpClient()
      .getUrl(Uri.parse(url))
      .then((req) => req.close())
      .then((res) => res.transform(utf8.decoder).join())
      .then((jsonStr) => json.decode(jsonStr) as List<dynamic>);
}

extension TrimmedCaseInsensitiveContain on String {
  bool trimmedContains(String other) => trim().toLowerCase().contains(
        other.trim().toLowerCase(),
      );
}
