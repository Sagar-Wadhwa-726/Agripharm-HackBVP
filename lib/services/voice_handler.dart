import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceHandler {
  // speec to text package in flutter
  final SpeechToText _speechToText = SpeechToText();

  // initialise the button for speech enabled as false initially
  bool _speechEnabled = false;

  // initialise speech to text facility
  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  Future<String> startListening() async {
    final completer = Completer<String>();
    _speechToText.listen(
      onResult: (result) {
        if (result.finalResult) {
          completer.complete(result.recognizedWords);
        }
      },
    );
    return completer.future;
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  SpeechToText get speechToText => _speechToText;
  bool get isEnabled => _speechEnabled;
}
