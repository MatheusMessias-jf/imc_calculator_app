import '../classes/imc.dart';

class ImcRepository {
  List<Imc> _imcs = [];

  void addImc(Imc imc) {
    _imcs.add(imc);
  }

  String getLastImc() {
    return _imcs[0].toString();
  }

  List<Imc> get imcs => _imcs;

  void removeImc(String id) {
    _imcs.remove(_imcs.where((element) => element.id == id).first);
  }
}
