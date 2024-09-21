import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';

class ChatController extends GetxController {
  final RxList<types.Message> messages = <types.Message>[].obs;
}
