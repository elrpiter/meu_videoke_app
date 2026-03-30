class KaraokeSong {
  final String title;
  final String artist;
  final String audioPath;   // Caminho do áudio
  final String videoPath;   // Caminho do vídeo de fundo
  final String lyricsPath;  // Caminho do arquivo de legenda (.lrc)

  KaraokeSong({
    required this.title,
    required this.artist,
    required this.audioPath,
    required this.videoPath,
    required this.lyricsPath,
  });
}