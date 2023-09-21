import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'imc_model.g.dart';

@HiveType(typeId: 0)
class IMCModel extends HiveObject {
  @HiveField(0)
  final String _id = UniqueKey().toString();
  @HiveField(1)
  double _weight = 0;
  @HiveField(3)
  double _height = 0;
  @HiveField(4)
  DateTime createdAt = DateTime.now();
  @HiveField(5)
  late double _imc;

  IMCModel();

  IMCModel.criar(this._height, this._weight) {
    _imc = _weight / (_height * _height);
  }

  String get id => _id;

  double get imc => _imc;

  double get height => _height;

  double get weight => _weight;
}
