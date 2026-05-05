import 'package:app_escolar/conceitos_basicos.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const AppEscolar());
}

class AppEscolar extends StatelessWidget {
  const AppEscolar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Escolar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: ConceitosBasicos(),
      debugShowCheckedModeBanner: false,
    );
  }
}