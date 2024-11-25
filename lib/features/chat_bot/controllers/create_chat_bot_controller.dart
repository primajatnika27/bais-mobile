import 'package:bais_mobile/data/repositories/chat_bot_repository.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateChatBotController extends GetxController {
  List<Message> messageList = [];

  late final ChatController chatController;
  late final ScrollController scrollController;
  var chatViewState = ChatViewState.hasMessages.obs;

  final ChatBotRepository _chatBotRepository = ChatBotRepository();

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    chatController = ChatController(
      initialMessageList: messageList,
      scrollController: scrollController,
      currentUser: ChatUser(id: '1', name: 'User'),
      otherUsers: [
        ChatUser(id: '2', name: 'Bot'),
      ],
    );
  }

  void onSendTap(String messageValue, ReplyMessage replyMessage, MessageType messageType) async {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: messageValue,
      createdAt: DateTime.now(),
      sentBy: '1',
      replyMessage: replyMessage,
      messageType: messageType,
    );
    chatController.addMessage(message);

    chatViewState.value = ChatViewState.loading;
    final response = await _chatBotRepository.getPredict(messageValue);

    try {
      final response = await _chatBotRepository.getPredict(messageValue);

      final botMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: response.jawaban ?? 'I\'m sorry, I don\'t understand.',
        createdAt: DateTime.now(),
        sentBy: '2',
        replyMessage: replyMessage,
        messageType: MessageType.text,
      );

      final botMessageArticle = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: response.sumber?.hasilOcrTeks21Pdf ?? 'I\'m sorry, I don\'t understand.',
        createdAt: DateTime.now(),
        sentBy: '2',
        replyMessage: replyMessage,
        messageType: MessageType.text,
      );
      chatViewState.value = ChatViewState.hasMessages;
      chatController.addMessage(botMessage);
      chatController.addMessage(botMessageArticle);

    } catch (e) {
      final errorMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: 'Request timed out. Please try again later.',
        createdAt: DateTime.now(),
        sentBy: '2',
        replyMessage: replyMessage,
        messageType: MessageType.text,
      );
      chatController.addMessage(errorMessage);
    } finally {
      chatViewState.value = ChatViewState.hasMessages; // Set state ke hasMessages setelah selesai
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    chatController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    scrollController.dispose();
    chatController.dispose();
    super.dispose();
  }
}