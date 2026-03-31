import 'dart:async';
import 'package:record/record.dart';

class MicHandler {
  final _audioRecorder = AudioRecorder();
  StreamSubscription<Amplitude>? _amplitudeSubscription;
  
  // Função que começa a "escutar" o volume
  void startListening(Function(double) onVolumeChanged) async {
    // Verifica se temos permissão
    if (await _audioRecorder.hasPermission()) {
      // Configuração para apenas monitorar o volume (sem salvar arquivo)
      const config = RecordConfig();
      
      // Começamos a monitorar a amplitude a cada 100ms
      _amplitudeSubscription = _audioRecorder
          .onAmplitudeChanged(const Duration(milliseconds: 100))
          .listen((amp) {
            // amp.current vai de -50 (silêncio) a 0 (muito alto)
            onVolumeChanged(amp.current);
          });

      // Iniciamos tecnicamente a gravação em um fluxo temporário
      // No Windows, isso ativa o driver de áudio
      await _audioRecorder.start(config, path: ''); 
    }
  }

  void stop() {
    _amplitudeSubscription?.cancel();
    _audioRecorder.dispose();
  }
}