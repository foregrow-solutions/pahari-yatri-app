import 'app.config.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

OpenAI openAI = OpenAI.instance.build(
    token: openAIAPIKey,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 60)),
    enableLog: true);
