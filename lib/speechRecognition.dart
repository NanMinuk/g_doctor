import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechRecognitionService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false;
  String recognizedText = '';

  Future<void> initialize() async {
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (!available) {
      print('음성 인식을 사용할 수 없음');
    }
  }

  Future<void> startListening({
    required Function(String text) onResult,
    required Function onListeningChanged,
  }) async {
    await _speech.listen(
      localeId: "ko-KR",
      onResult: (val) {
        if (val.finalResult) {
          onResult(val.recognizedWords);
          onListeningChanged();
        }
      },
    );
  }

  void stopListening() => _speech.stop();
}


