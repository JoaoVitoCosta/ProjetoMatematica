import 'package:flutter/material.dart';

class MatematicaScreen extends StatefulWidget {
  const MatematicaScreen({super.key});

  @override
  State<MatematicaScreen> createState() => _MatematicaScreenState();
}

class _MatematicaScreenState extends State<MatematicaScreen> {
  String _output = "0";
  String _operand = "";
  String _value = "0";
  String _operator = "";
  bool _isNewOperation = true;

  // botoes para os números 
  Widget btnNumber(String label, {Color? color}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[300],
            foregroundColor: Colors.black87,
            padding: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            buttonPressed(label);
          },
        ),
      ),
    );
  }

  // Botão das operações
  Widget btnOperator(String label, {Color? color}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            buttonPressed(label);
          },
        ),
      ),
    );
  }

  // Para limpar
  Widget btnClear() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'C',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            buttonPressed('C');
          },
        ),
      ),
    );
  }

  // Resultado botão
  Widget btnResult() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            '=',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            buttonPressed('=');
          },
        ),
      ),
    );
  }

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Limpa tudo
        _output = "0";
        _value = "0";
        _operand = "";
        _operator = "";
        _isNewOperation = true;
      } else if (buttonText == "+/-") {
        // Troca de sinal
        if (_output.startsWith("-")) {
          _output = _output.substring(1);
        } else {
          _output = "-$_output";
        }
      } else if (buttonText == "." && !_output.contains(".")) {
        // Adicionar decimal
        _output = _output == "0" ? "0." : _output + ".";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        // Operador
        _operand = _output;
        _operator = buttonText;
        _isNewOperation = true;
      } else if (buttonText == "=") {
        // Calcular resultado
        if (_operator.isNotEmpty && _operand.isNotEmpty) {
          double resultado = 0;
          double num1 = double.parse(_operand);
          double num2 = double.parse(_output);

          // Validação se a divisão por zero
          if (_operator == "÷" && num2 == 0) {
            _output = "ERRO: Divisão por zero!";
            _operator = "";
            _operand = "";
            _isNewOperation = true;
            return;
          }

          switch (_operator) {
            case "+":
              resultado = num1 + num2;
              break;
            case "-":
              resultado = num1 - num2;
              break;
            case "×":
              resultado = num1 * num2;
              break;
            case "÷":
              resultado = num1 / num2;
              break;
          }

          _output = resultado.toString();
          _operator = "";
          _operand = "";
          _isNewOperation = true;
        }
      } else {
        // Número
        if (_isNewOperation) {
          _output = buttonText;
          _isNewOperation = false;
        } else {
          _output = _output == "0" ? buttonText : _output + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: <Widget>[
          // Tela de exibição
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    _output,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Teclado
          Column(
            children: [
              // Primeira linha
              Row(
                children: [
                  btnClear(),
                  btnOperator('+/-'),
                  btnOperator('%'),
                  btnOperator('÷', color: Colors.orange[700]),
                ],
              ),
              // Segunda linha
              Row(
                children: [
                  btnNumber('7'),
                  btnNumber('8'),
                  btnNumber('9'),
                  btnOperator('×', color: Colors.orange[700]),
                ],
              ),
              // Terceira linha
              Row(
                children: [
                  btnNumber('4'),
                  btnNumber('5'),
                  btnNumber('6'),
                  btnOperator('-', color: Colors.orange[700]),
                ],
              ),
              // Quarta linha
              Row(
                children: [
                  btnNumber('1'),
                  btnNumber('2'),
                  btnNumber('3'),
                  btnOperator('+', color: Colors.orange[700]),
                ],
              ),
              // Quinta linha
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.all(24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          '0',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => buttonPressed('0'),
                      ),
                    ),
                  ),
                  btnNumber('.'),
                  btnResult(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}