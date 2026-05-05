import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int pontuacao = 0;
  int perguntaAtual = 0;
  List<String> respostasCorretas = [];
  bool respondeu = false;
  String? respostaSelecionada;

  // Questões do quiz
  final List<Map<String, dynamic>> questoes = [
    {
      'pergunta': 'Quanto é 15 + 27?',
      'opcoes': ['32', '40', '42', '45'],
      'correta': 2,
    },
    {
      'pergunta': 'Quanto é 8 × 9?',
      'opcoes': ['64', '72', '81', '90'],
      'correta': 1,
    },
    {
      'pergunta': 'Quanto é 100 ÷ 4?',
      'opcoes': ['20', '25', '30', '35'],
      'correta': 1,
    },
    {
      'pergunta': 'Quanto é 50 - 23?',
      'opcoes': ['25', '27', '29', '31'],
      'correta': 1,
    },
    {
      'pergunta': 'Qual é 3/4 de 20?',
      'opcoes': ['12', '15', '18', '20'],
      'correta': 1,
    },
  ];

  @override
  void initState() {
    super.initState();
    _novaPergunta();
  }

  void _novaPergunta() {
    setState(() {
      pontuacao = 0;
      perguntaAtual = 0;
      respondeu = false;
      respostaSelecionada = null;
      respostasCorretas.clear();
    });
    _proximaPergunta();
  }

  void _proximaPergunta() {
    setState(() {
      if (perguntaAtual < questoes.length) {
        respostaSelecionada = null;
        respondeu = false;
      }
    });
  }

  void _responder(int indice) {
    setState(() {
      respondeu = true;
      respostaSelecionada = indice.toString();
      
      if (indice == questoes[perguntaAtual]['correta']) {
        pontuacao++;
      }
      
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          perguntaAtual++;
          if (perguntaAtual < questoes.length) {
            _proximaPergunta();
          }
        });
      });
    });
  }

  Widget _opcao(int indice, String texto) {
    bool correta = indice == questoes[perguntaAtual]['correta'];
    bool selecionada = respostaSelecionada == indice.toString();
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selecionada 
            ? (correta ? Colors.green : Colors.red)
            : (respondeu && correta ? Colors.green : null),
          padding: const EdgeInsets.all(16),
        ),
        onPressed: respondeu ? null : () => _responder(indice),
        child: Text(texto, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (perguntaAtual >= questoes.length) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.emoji_events, size: 100, color: Colors.amber[600]),
            const SizedBox(height: 20),
            Text(
              'Quiz Concluído!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Pontuação: $pontuacao/${questoes.length}',
              style: TextStyle(fontSize: 24, color: Colors.grey[700]),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _novaPergunta,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text('Novo Quiz', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      );
    }

    final questao = questoes[perguntaAtual];

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          // Barra de progresso
          LinearProgressIndicator(
            value: (perguntaAtual + 1) / questoes.length,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 30),
          
          // Pergunta
          Text(
            '${perguntaAtual + 1}/${questoes.length}',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          Text(
            questao['pergunta'],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          
          // Opções
          ...List.generate(4, (i) => _opcao(i, questao['opcoes'][i])),
        ],
      ),
    );
  }
}