import 'package:flutter/material.dart';
import 'package:play_with_rxdart/models/thing.dart';

@immutable
class Person extends Thing {
  final int age;
  const Person({
    required this.age,
    required String name,
  }) : super(name: name);

  @override
  String toString() {
    return "Person , name: $name, age: $age";
  }

  Person.fromJson(Map<String, dynamic> json)
      : age = json['age'] as int,
        super(
          name: json['name'] as String,
        );
}
