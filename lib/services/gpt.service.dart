import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import '../common/globalvars.dart';

class GPTService {
  final maxToken = 1000;

  String preparePlan(
      {required String prompt, String? place, String? weather, Function(String)? listen}) {
    String response = '';
    prompt = 'prompt:$prompt *(The prompt may include travel-related information such as place, location, climate, season, etc.)*'
        '${place != null && place.isNotEmpty ? 'place:$place' : ''}'
        '${weather != null && weather.isNotEmpty ? 'weather:$weather' : ''}'
        'response:['
        ' # 📌 {{ Place }}'
        ' Short description of the prompted place *(Provides tourism perspective, historical overview, etc.)*'
        ' [NEW_LINE]'
        ' ## 🧭 Travel plan *('
        '   - Consider today if day unspecified in query'
        '   - Nearby attraction places'
        '   - Smartly prepare the plan *(by default recommend with public transportation)'
        '   - Split the plan using specified emojis: ((### 📅 Day X [HORIZONTAL_LINE]) - (### 🌅 **Morning**), (### ☀️ **Noon**), (### 🌇 **Evening**), (### 🌙 **Night**), (Horizontal break and space at days gap), (unspecified content must be unformatted))'
        '   - Include return journey plan if boarding location is specified'
        '   - Provide a detailed plan'
        '   - Add images in between plan as [IMG(place)]'
        '   - Add relevant emojis'
        ')'
        ' [NEW_LINE]'
        ' ## 🖇️ Route options'
        ' [NEW_LINE]'
        ' ## 🩺 Precautions'
        ']'
        'Result as markdown [*Note: If there is no matching place, the description will be unknown; do not display query notes or request description; plan considering health, break hours, activities, etc.; The response is limited to ${maxToken - 32} tokens]';

    final request = CompleteText(
      prompt: prompt,
      maxTokens: maxToken,
      model: TextDavinci3Model(),
    );

    openAI.onCompletionSSE(request: request).listen((it) {
      response += it.choices.last.text;
      if (listen != null) {
        listen(it.choices.last.text);
      }
    });

    return response;
  }

  String findPlace({required String prompt, Function(String)? listen}) {
    String response = '';
    prompt = 'prompt:$prompt *(The prompt may include travel-related information such as place, location, climate, season, etc.)*'
        'response:[find place name with location name only]'
        'Result as an inline string, max chars 32';

    final request = CompleteText(
      prompt: prompt,
      maxTokens: maxToken,
      model: TextDavinci3Model(),
    );

    openAI.onCompletionSSE(request: request).listen((it) {
      response += it.choices.last.text;
      if (listen != null) {
        listen(it.choices.last.text);
      }
    });

    return response;
  }
  String retrieveDateFromPrompt({required String prompt, Function(String)? listen}) {
    String response = '';
    prompt = 'prompt:$prompt *(The prompt may include travel-related information such as place, location, climate, season, etc.)*'
        'response:[retrieve date from prompt if unspecified consider today and return (millisecondsSinceEpoch ~/ 1000)]'
        'Result as an inline string';

    final request = CompleteText(
      prompt: prompt,
      maxTokens: maxToken,
      model: TextDavinci3Model(),
    );

    openAI.onCompletionSSE(request: request).listen((it) {
      response += it.choices.last.text;
      if (listen != null) {
        listen(it.choices.last.text);
      }
    });

    return response;
  }
  String generateAttractiveQuote({required String prompt, Function(String)? listen}) {
    String response = '';
    prompt = 'prompt:$prompt *(The prompt may include travel-related information such as place, location, climate, season, etc.)*'
        'response:[generate an attractive quote about $prompt]'
        'Result as an inline string';

    final request = CompleteText(
      prompt: prompt,
      maxTokens: maxToken,
      model: TextDavinci3Model(),
    );

    openAI.onCompletionSSE(request: request).listen((it) {
      response += it.choices.last.text;
      if (listen != null) {
        listen(it.choices.last.text);
      }
    });

    return response;
  }

}
