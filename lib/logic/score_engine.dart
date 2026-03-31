import 'dart:math';

class ScoreEngine {
  double _accumulatedScore = 0;
  int _totalChecks = 0;

  // Acumula os pontos internamente sem mostrar na tela
  void processPerformance(double micVolume, bool isLyricsActive) {
    _totalChecks++;
    if (isLyricsActive && micVolume > -25.0) {
      // Quanto mais alto (perto de 0), mais pontos ganha
      _accumulatedScore += (micVolume + 40).clamp(0, 40); 
    }
  }

  // Calcula a nota final de 0 a 100
  int calculateFinalScore() {
    if (_totalChecks == 0) return 0;
    // Normaliza a pontuação para uma escala de 100
    double rawResult = (_accumulatedScore / (_totalChecks * 15)) * 100;
    return min(100, rawResult.toInt());
  }

  // O "Gran Finale": Comentários baseados na nota
  String getComment(int score) {
    if (score >= 95) return "EXCELENTE! Você é um artista profissional! 🌟";
    if (score >= 80) return "MUITO BOM! Já pode cobrar ingresso! 🎤";
    if (score >= 60) return "BOA! Com um pouco mais de treino chega lá. 👍";
    if (score >= 40) return "FOI QUASE! O importante é se divertir. 😊";
    return "OPS... Melhor ficarmos só no chuveiro por enquanto! 🚿";
  }

  void reset() {
    _accumulatedScore = 0;
    _totalChecks = 0;
  }
}