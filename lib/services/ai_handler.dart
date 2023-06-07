// file to handle chat gpt (making requests and getting responses using the chat gpt sdk)
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class AIHandler {
  final _openAI = OpenAI.instance.build(
    // api key from open AI
    token: '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',

    // basic information
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
    ),
  );

  // returns a string in Future, which means after some time asynchronously
  // this string is the response which we get from the chat gpt 
  Future<String> getResponse(String message) async {
    try {
      // make a request to chat gpt api
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": message})
      ], maxToken: 200, model: kChatGptTurbo0301Model);

      final response = await _openAI.onChatCompletion(request: request);
      if (response != null) {
        return response.choices[0].message.content.trim();
      }

      return 'Technical error / तकनीकी खराबी ';
    } catch (e) {
      return 'Technical error / तकनीकी खराबी';
    }
  }

  // remove from the memory
  void dispose() {
    _openAI.close();
  }
}
