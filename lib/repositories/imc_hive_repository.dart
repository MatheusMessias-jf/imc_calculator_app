import 'package:hive/hive.dart';
import 'package:imc_calculator_app/model/imc_model.dart';

class IMCHiveRepository {
  static late Box _box;

  IMCHiveRepository._criar();

  static Future<IMCHiveRepository> carregar() async {
    if (Hive.isBoxOpen('imcRepository')) {
      _box = Hive.box('imcRepository');
    } else {
      _box = await Hive.openBox('imcRepository');
    }
    return IMCHiveRepository._criar();
  }

  salvar(IMCModel imcModel) {
    _box.add(imcModel);
  }

  excluir(IMCModel imcModel) {
    imcModel.delete();
  }

  List<IMCModel> obterDados() {
    return _box.values.cast<IMCModel>().toList();
  }
}
