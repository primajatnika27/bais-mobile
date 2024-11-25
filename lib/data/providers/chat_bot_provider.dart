import 'package:bais_mobile/data/models/chat_bot/chat_bot_model.dart';
import 'package:bais_mobile/services/http_service.dart';

class ChatBotProvider {
  final HttpService _httpService;
  ChatBotProvider(this._httpService);

  Future<ChatBotResponse> getPredict(String prompt) async {
    final response = await _httpService.post('/predict', {
      'prompt': prompt,
      'regenerate': 'N',
    });

    if (response.statusCode == 200) {
      return ChatBotResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load announcements');
    }
  }
}