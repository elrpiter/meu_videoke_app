import 'dart:async';
import 'package:flutter/material.dart';
import '../logic/lyric_engine.dart';
import '../logic/score_engine.dart';
import '../logic/mic_handler.dart';

class PlayerScreen extends StatefulWidget {
  final String songTitle;
  const PlayerScreen({super.key, required this.songTitle});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final ScoreEngine _scoreEngine = ScoreEngine();
  final MicHandler _micHandler = MicHandler();
  
  Duration _currentTime = Duration.zero;
  Timer? _timer;
  
  // Letra para teste
  final List<LyricLine> _lyrics = [
    LyricLine(time: const Duration(seconds: 2), text: "Diz que é verdade..."),
    LyricLine(time: const Duration(seconds: 5), text: "É uma saudade..."),
    LyricLine(time: const Duration(seconds: 8), text: "Que eu sinto de você!"),
  ];

  @override
  void initState() {
    super.initState();
    _startKaraoke();
    
    // Liga o microfone e processa a performance
    _micHandler.startListening((volume) {
      bool hasLyrics = LyricEngine.getCurrentLyric(_lyrics, _currentTime).isNotEmpty;
      _scoreEngine.processPerformance(volume, hasLyrics);
    });
  }

  void _startKaraoke() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (mounted) {
        setState(() {
          _currentTime += const Duration(milliseconds: 100);
          
          // Termina após 12 segundos (simulação)
          if (_currentTime.inSeconds >= 12) {
            _timer?.cancel();
            _showFinalScore();
          }
        });
      }
    });
  }

  void _showFinalScore() {
    int finalScore = _scoreEngine.calculateFinalScore();
    String comment = _scoreEngine.getComment(finalScore);

    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("FIM DO SHOW!", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("$finalScore", 
              style: const TextStyle(color: Colors.greenAccent, fontSize: 80, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 10),
            Text(comment, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fecha Dialog
              Navigator.pop(context); // Volta Home
            },
            child: const Text("VOLTAR AO MENU", style: TextStyle(color: Colors.deepPurpleAccent)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _micHandler.stop(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentText = LyricEngine.getCurrentLyric(_lyrics, _currentTime);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Fundo Estilizado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.deepPurple, Colors.black],
              ),
            ),
          ),
          // Letra Centralizada
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                currentText,
                textAlign: TextAlign.center, // textAlign fica fora do TextStyle
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Botão de Sair
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}