import 'package:flutter/material.dart';
import 'package:imc_calculator_app/classes/imc.dart';
import 'package:imc_calculator_app/repositories/imc_repository.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  var heightController = TextEditingController(text: "");
  var weightController = TextEditingController(text: "");
  var imcRepository = ImcRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(169, 111, 213, 0.8),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
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
                      onChanged: (value) {
                        debugPrint(value);
                      },
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
                      onChanged: (value) {
                        debugPrint(value);
                      },
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
                          print("Botao pressionado");
                          if (heightController.text.trim() == "" ||
                              weightController.text.trim() == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Insira corretamente seus dados")));
                          } else {
                            print("Dados inseridos corretamente");
                            setState(() {
                              imcRepository.addImc(Imc(
                                  double.parse(heightController.text),
                                  double.parse(weightController.text)));
                            });
                            print("IMC adicionado");
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
                            itemCount: imcRepository.imcs.length,
                            itemBuilder: (BuildContext bc, int index) {
                              var imc = imcRepository.imcs[index];
                              return Card(
                                child: Dismissible(
                                  onDismissed:
                                      (DismissDirection dismissDirection) {
                                    imcRepository.imcs.remove(imc);
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
      )),
    );
  }
}
