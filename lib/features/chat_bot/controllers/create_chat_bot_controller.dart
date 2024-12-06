import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bais_mobile/core/dialogs/general_dialogs.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/data/repositories/chat_bot_repository.dart';
import 'package:chatview/chatview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateChatBotController extends GetxController
    with SingleGetTickerProviderMixin {
  var file = Rx<File?>(null);
  var platformFile = Rx<PlatformFile?>(null);
  AnimationController? loadingController;

  List<Message> messageList = [];

  late final ChatController chatController;
  late final ScrollController scrollController;
  var chatViewState = ChatViewState.hasMessages.obs;

  final ChatBotRepository _chatBotRepository = ChatBotRepository();

  @override
  void onInit() {
    super.onInit();
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        update();
      });
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

  void onSendTap(String messageValue, ReplyMessage replyMessage,
      MessageType messageType) async {
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
      chatViewState.value =
          ChatViewState.hasMessages; // Set state ke hasMessages setelah selesai
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
    } else {}
  }

  void selectFile() async {
    final pickedFile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'csv']);

    if (pickedFile != null) {
      file.value = File(pickedFile.files.single.path!);
      platformFile.value = pickedFile.files.first;
      uploadFile();
    }
  }

  Future<void> uploadFile() async {
    if (file.value == null) return;

    try {
      String fileName = platformFile.value!.name;
      var response = await _chatBotRepository.postPredictFile(
        file.value!.path,
        fileName,
        onSendProgress: (int sent, int total) {
          loadingController?.value = sent / total;
        },
      );

      if (response.statusCode == 200) {
        GeneralDialog.showSnackBar(
          ContentType.success,
          'Success',
          'File uploaded successfully',
        );
      } else {
        GeneralDialog.showSnackBar(
          ContentType.failure,
          'Error',
          'Failed to upload file',
        );
      }
    } catch (e) {
      GeneralDialog.showSnackBar(ContentType.failure, 'Error', e.toString());
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
