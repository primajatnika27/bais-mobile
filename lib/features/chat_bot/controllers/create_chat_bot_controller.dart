import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/data/repositories/chat_bot_repository.dart';
import 'package:chatview/chatview.dart';
import 'package:file_picker/file_picker.dart';
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

    try {
      chatController.setTypingIndicator = true;
      final response = await _chatBotRepository.getPredict(messageValue);

      final botMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: response.jawaban ?? 'I\'m sorry, I don\'t understand.',
        createdAt: DateTime.now(),
        sentBy: '2',
        replyMessage: replyMessage,
        messageType: MessageType.text,
      );

      // final botMessageArticle = Message(
      //   id: DateTime.now().millisecondsSinceEpoch.toString(),
      //   message: response.sumber?.hasilOcrTeks21Pdf ?? 'I\'m sorry, I don\'t understand.',
      //   createdAt: DateTime.now(),
      //   sentBy: '2',
      //   replyMessage: replyMessage,
      //   messageType: MessageType.text,
      // );
      chatViewState.value = ChatViewState.hasMessages;
      chatController.addMessage(botMessage);
      // chatController.addMessage(botMessageArticle);
      chatController.setTypingIndicator = false;

    } catch (e) {
      final errorMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: 'Request timed out. Please try again later.',
        createdAt: DateTime.now(),
        sentBy: '2',
        replyMessage: replyMessage,
        messageType: MessageType.text,
      );
      chatController.setTypingIndicator = false;
      chatController.addMessage(errorMessage);
    } finally {
      chatViewState.value = ChatViewState.hasMessages; // Set state ke hasMessages setelah selesai
    }
  }

  void onUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Get.snackbar(
        'Upload',
        'Article uploaded successfully',
        backgroundColor: AppTheme.green700,
        colorText: Colors.white,
      );
    } else {

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
