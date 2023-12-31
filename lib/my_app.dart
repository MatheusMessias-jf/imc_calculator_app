import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imc_calculator_app/pages/calculator.dart';
import 'package:imc_calculator_app/pages/calculator_hive_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: GoogleFonts.robotoTextTheme()),
      home: CalculatorHivePage(),
    );
  }
}
