import 'package:dio/dio.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/chat_service.dart';

class ChatController extends GetxController {
  final Dio dio;
  ChatController({required this.dio});

  final RxList<types.Message> messages = <types.Message>[].obs;
  final isLoading = false.obs;

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

        messages.add(response as types.Message);
      },
    );
    isLoading.value = false;
  }
}
