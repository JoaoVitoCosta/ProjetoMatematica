import 'package:app_escolar/home_screen.dart';
import 'package:flutter/material.dart';

class ConceitosBasicos extends StatelessWidget {
  const ConceitosBasicos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Base Matemática', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 230, 75, 4),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _titulo('A ideia central'),
            _cardTexto(
              'A Matemática básica é usada para resolver problemas do dia a dia, '
              'envolvendo números e operações simples.',
            ),

            _titulo('Conceitos básicos'),
            _operacao('Adição (+)', 'Somar valores', '2 + 3 = 5'),
            _operacao('Subtração (-)', 'Diminuir valores', '5 - 2 = 3'),
            _operacao('Multiplicação (×)', 'Soma repetida', '3 × 4 = 12'),
            _operacao('Divisão (÷)', 'Repartir em partes iguais', '10 ÷ 2 = 5'),

            _titulo('Exemplo prático'),
            _cardTexto(
              'Se você tem 10 reais e gasta 4, faz uma subtração (10 - 4 = 6).\n\n'
              'Se comprar 3 itens de 2 reais cada, usa multiplicação (3 × 2 = 6).',
            ),

            const SizedBox(height: 24),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen()),
                  );
                },
                icon: const Icon(Icons.calculate),
                label: const Text('Ir para a calculadora'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 230, 75, 4),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titulo(String texto) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 230, 75, 4),
        ),
      ),
    );
  }

  Widget _cardTexto(String texto) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          texto,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _operacao(String titulo, String descricao, String exemplo) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.functions, color: Color.fromARGB(255, 230, 75, 4)),
        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$descricao\nEx: $exemplo'),
      ),
    );
  }
}