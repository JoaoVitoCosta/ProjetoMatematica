import 'package:flutter/material.dart';

class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});

  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  String _tela = "0";
  String _valor1 = "";
  String _operador = "";
  bool _novoNumero = true;

  void _botaoPressionado(String texto) {
    setState(() {
      if (texto == "C") {
        _tela = "0";
        _valor1 = "";
        _operador = "";
        _novoNumero = true;
      } else if (texto == "=") {
        if (_valor1.isNotEmpty && _operador.isNotEmpty) {
          double num1 = double.parse(_valor1);
          double num2 = double.parse(_tela);

          // ✅ DIVISÃO POR ZERO PROTEGIDA
          if (_operador == "÷" && num2 == 0) {
            _tela = "ERRO!";
            return;
          }

          double resultado = switch (_operador) {
            "+" => num1 + num2,
            "-" => num1 - num2,
            "×" => num1 * num2,
            "÷" => num1 / num2,
            _ => 0,
          };

          _tela = resultado.toString();
          _novoNumero = true;
        }
      } else if (["+","−","×","÷"].contains(texto)) {
        _valor1 = _tela;
        _operador = texto == "−" ? "-" : texto;
        _novoNumero = true;
      } else {
        _tela = _novoNumero ? texto : _tela + texto;
        _novoNumero = false;
      }
    });
  }

  Widget _botao(String texto, {Color? cor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: cor ?? Colors.grey[300],
            foregroundColor: cor == null ? Colors.black : Colors.white,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () => _botaoPressionado(texto),
          child: Text(texto, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TELA
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(40),
            child: Text(
              _tela,
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // BOTÕES
        Column(
          children: [
            Row(children: [_botao("C", cor: Colors.red), _botao("÷", cor: Colors.orange)]),
            Row(children: [_botao("7"), _botao("8"), _botao("9"), _botao("×", cor: Colors.orange)]),
            Row(children: [_botao("4"), _botao("5"), _botao("6"), _botao("−", cor: Colors.orange)]),
            Row(children: [_botao("1"), _botao("2"), _botao("3"), _botao("+", cor: Colors.orange)]),
            Row(children: [
              Expanded(flex: 2, child: _botao("0")),
              _botao("."),
              _botao("=", cor: Colors.green),
            ]),
          ],
        ),
      ],
    );
  }
}