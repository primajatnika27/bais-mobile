import 'package:bais_mobile/data/models/chat_bot/chat_bot_model.dart';
import 'package:bais_mobile/services/http_service.dart';
import 'package:dio/dio.dart';

class ChatBotProvider {
  final HttpService _httpService;
  final HttpService _httpServiceUpload;

  ChatBotProvider(this._httpService, this._httpServiceUpload);

  Future<Response> postPredictFile(
    String filePath,
    String fileName, {
    required Function(int, int) onSendProgress,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath, filename: fileName),
        "tipe_data": "PDF",
      });

      return await _httpServiceUpload.postFile(
        '/predict',
        formData,
        onSendProgress: onSendProgress,
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ChatBotResponse> getPredict(String prompt) async {
    final response = await _httpService.post('/predict', {
      'prompt': prompt,
      'regenerate': 'N',
    });

    if (response.statusCode == 200) {
      print(response.data);
      if (response.data == 0) {
        throw Exception('Response data is empty');
      }
      return ChatBotResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load announcements');
    }
  }
}
