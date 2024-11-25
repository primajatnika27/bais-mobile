import 'package:bais_mobile/core/constants/api_constant.dart';
import 'package:bais_mobile/data/models/chat_bot/chat_bot_model.dart';
import 'package:bais_mobile/data/providers/chat_bot_provider.dart';
import 'package:bais_mobile/services/http_service.dart';

class ChatBotRepository {
  late final ChatBotProvider _provider;

  ChatBotRepository() {
    final httpService = HttpService(baseUrl: ApiConstant.chatBotUrl);
    _provider = ChatBotProvider(httpService);
  }

  Future<ChatBotResponse> getPredict(String prompt) async => await _provider.getPredict(prompt);
}