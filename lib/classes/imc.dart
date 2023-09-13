import 'package:flutter/material.dart';

class Imc {
  final String _id = UniqueKey().toString();
  final double _weight;
  final double _height;
  DateTime createdAt = DateTime.now();
  double _imc = 0;

  Imc(this._height, this._weight) {
    _imc = _weight / (_height * _height);
  }

  String get id => _id;

  double get weight => _weight;

  double get height => _height;

  double get imc => _imc;
}
