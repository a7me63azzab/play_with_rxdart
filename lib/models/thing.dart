import 'package:flutter/material.dart' show immutable;

@immutable
class Thing {
  final String name;
  const Thing({required this.name});
}
