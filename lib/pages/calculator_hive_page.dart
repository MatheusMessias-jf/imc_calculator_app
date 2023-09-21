import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imc_calculator_app/classes/imc.dart';
import 'package:imc_calculator_app/model/imc_model.dart';
import 'package:imc_calculator_app/repositories/imc_hive_repository.dart';
import 'package:imc_calculator_app/repositories/imc_repository.dart';

class CalculatorHivePage extends StatefulWidget {
  const CalculatorHivePage({super.key});

  @override
  State<CalculatorHivePage> createState() => _CalculatorHivePageState();
}

class _CalculatorHivePageState extends State<CalculatorHivePage> {
  //var imcRepository = ImcRepository(); alterado para hive
  late IMCHiveRepository imcRepository;
  late Box box;
  List<IMCModel> _imcs = [];
  var heightController = TextEditingController();
  var weightController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
    //print(heightController.text);
  }

  void carregarDados() async {
    imcRepository = await IMCHiveRepository.carregar();
    _imcs = imcRepository.obterDados();
    if (Hive.isBoxOpen('calcIMCData')) {
      box = Hive.box('calcIMCData');
    } else {
      box = await Hive.openBox('calcIMCData');
    }
    heightController.text = box.get('height') ?? "";
    weightController.text = box.get('weight') ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(169, 111, 213, 0.8),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Calcule seu IMC: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Text("Qual sual altura: "),
                  Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      height: 30,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: heightController,
                        onChanged: (value) {},
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(13),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple[600]!)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple[600]!)),
                            hintStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.height,
                              color: Colors.white,
                            )),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Qual seu peso: "),
                  Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      height: 30,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: weightController,
                        onChanged: (value) {},
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(13),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple[600]!)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple[600]!)),
                            hintStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.monitor_weight_outlined,
                              color: Colors.white,
                            )),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            if (heightController.text.trim() == "" ||
                                weightController.text.trim() == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Insira corretamente seus dados")));
                            } else {
                              setState(() {
                                print(box.get('height'));
                                box.put('height', heightController.text);
                                box.put('weight', weightController.text);
                                imcRepository.salvar(IMCModel.criar(
                                    double.parse(heightController.text),
                                    double.parse(weightController.text)));
                                _imcs = imcRepository.obterDados();
                              });
                            }
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.deepPurple[600])),
                          child: const Text(
                            "CALCULAR",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    height: 500,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: _imcs.length,
                              itemBuilder: (BuildContext bc, int index) {
                                var imc = _imcs[index];
                                return Card(
                                  child: Dismissible(
                                    onDismissed:
                                        (DismissDirection dismissDirection) {
                                      imcRepository.excluir(imc);
                                    },
                                    key: Key(imc.id),
                                    child: ListTile(
                                      title: Text(
                                          "Valor do IMC: ${imc.imc.toStringAsFixed(2)}"),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                              "Peso: ${imc.weight.toStringAsFixed(2)}"),
                                          Text("Altura: ${imc.height}")
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
