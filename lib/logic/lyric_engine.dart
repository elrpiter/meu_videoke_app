class LyricLine {
  final Duration time; // Quando a frase aparece
  final String text;   // O que está escrito

  LyricLine({required this.time, required this.text});
}

class LyricEngine {
  // Transforma o texto bruto do arquivo .lrc em uma lista de objetos
  static List<LyricLine> parse(String rawLyrics) {
    List<LyricLine> lines = [];
    RegExp regExp = RegExp(r'\[(\d+):(\d+\.\d+)\](.*)');

    for (String line in rawLyrics.split('\n')) {
      var match = regExp.firstMatch(line);
      if (match != null) {
        int minutes = int.parse(match.group(1)!);
        double seconds = double.parse(match.group(2)!);
        String text = match.group(3)!.trim();

        Duration time = Duration(
          minutes: minutes,
          milliseconds: (seconds * 1000).toInt(),
        );

        lines.add(LyricLine(time: time, text: text));
      }
    }
    return lines;
  }

  // Descobre qual linha deve ser exibida com base no tempo atual da música
  static String getCurrentLyric(List<LyricLine> lyrics, Duration currentTime) {
    String currentText = "";
    for (var line in lyrics) {
      if (currentTime >= line.time) {
        currentText = line.text;
      } else {
        break;
      }
    }
    return currentText;
  }
}