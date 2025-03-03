import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/chat_service.dart';
import 'package:rise_pathway/src/models/chats/chat_model.dart';

class ChatController extends GetxController {
  final Dio dio;
  ChatController({required this.dio});

  final isLoading = false.obs;
  final RxList<ChatResponse> chats = <ChatResponse>[].obs;

  late final _services = ChatServices(dio: dio);

  Future<void> sendMessage({
    required String email,
    required String message,
  }) async {
    isLoading.value = true;
    final successOrFailure = await _services.sendMessage(
      email: email,
      message: message,
    );

    successOrFailure.fold(
      (failure) => logger.e(failure),
      (response) {
        Helpers.toast('Message sent successfully');
        // messages.addAll(response);
      },
    );
    isLoading.value = false;
  }

  Future<void> getMessages({
    required String email,
    required int limit,
    required int offset,
  }) async {
    isLoading.value = true;
    final successOrFailure = await _services.getMessages(
      email: email,
      limit: limit,
      offset: offset,
    );

    successOrFailure.fold(
      (failure) => logger.e(failure),
      (response) {
        chats.value = response;
      },
    );
    isLoading.value = false;
  }
}
