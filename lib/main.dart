import 'package:flutter/material.dart';
import 'home_screen.dart';

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
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}