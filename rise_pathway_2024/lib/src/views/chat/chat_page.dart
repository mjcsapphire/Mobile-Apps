import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:intl/intl.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/utils/colors.dart';
import 'package:rise_pathway/src/controllers/chat_controller.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatController = Get.find<ChatController>();
  final messageController = TextEditingController().obs;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: 'Chat',
        onTap: () => context.pop(),
        chatPage: true,
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://picsum.photos/1000/2000'),
              backgroundColor: AppColors.primaryColor,
            ),
            SizedBox(width: 2.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stephen Allen',
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.w),
                Text(
                  'Active now',
                  style: theme.bodySmall!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: Obx(() {
        print(messageController.value.text);
        return Chat(
          messageWidthRatio: 0.8,
          messages: chatController.messages.reversed.toList(),
          dateHeaderThreshold: 24 * 60 * 60 * 60,
          theme: DefaultChatTheme(
            inputTextCursorColor: AppColors.primaryColor,
            inputSurfaceTintColor: Colors.yellow,
            inputBackgroundColor: Colors.white,
            inputTextColor: Colors.white,
            inputPadding: EdgeInsets.zero,
            inputTextStyle: const TextStyle(
              color: Colors.black,
            ),
            primaryColor: AppColors.chatMessageColor,
            messageMaxWidth: 100.w,
          ),
          dateFormat: DateFormat('HH:mm'),
          dateIsUtc: false,
          avatarBuilder: (author) => const CircleAvatar(),
          customDateHeaderText: (p0) => DateFormat('yMMMd').format(p0),
          textMessageOptions: const TextMessageOptions(
            isTextSelectable: true,
          ),
          bubbleBuilder: (child,
              {required message, required nextMessageInGroup}) {
            return MessageTile(
              message: (child as TextMessage).message.text,
              sendByMe: message.author.id == '0',
              time: DateFormat('hh:mm a').format(
                DateTime.fromMillisecondsSinceEpoch(message.createdAt ?? 0),
              ),
            );
          },
          customBottomWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            child: Obx(() => Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.emoji_emotions_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: messageController.value,
                        style: theme.bodySmall,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: theme.bodySmall,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.attach_file_rounded,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Container(
                      height: 5.5.h,
                      width: 5.5.h,
                      margin: EdgeInsets.only(right: 2.w),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                        gradient: AppColorsGredients.primaryTopToBottom,
                      ),
                      child: IconButton(
                        onPressed: () {
                          final types.TextMessage message = types.TextMessage(
                            author: const types.User(id: '0'),
                            id: Random().nextInt(100000).toString(),
                            text: messageController.value.text,
                            createdAt: DateTime.now().millisecondsSinceEpoch,
                            showStatus: true,
                            status: types.Status.delivered,
                          );
                          chatController.messages.add(message);
                          messageController.value.text = '';
                        },
                        color: AppColors.primaryColor,
                        icon: Icon(
                          messageController.value.text.isEmpty
                              ? Icons.mic
                              : Icons.send,
                          size: 2.5.h,
                          color: AppColors.white,
                          fill: .1,
                        ),
                      ),
                    )
                  ],
                )),
          ),
          onSendPressed: (value) {
            final types.TextMessage message = types.TextMessage(
              author: types.User(id: messageController.value.text),
              id: value.text,
              text: value.text,
            );
            chatController.messages.add(message);
          },
          user: const types.User(
            id: '0',
          ),
        );
      }),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final String time;

  const MessageTile({
    super.key,
    required this.message,
    required this.sendByMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.only(
          // left: sendByMe ? 0 : 8,
          // right: sendByMe ? 8 : 0,
          ),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.zero,
        padding:
            const EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: sendByMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
          color:
              sendByMe ? Colors.blue : AppColors.lighterGrey.withOpacity(0.3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Positioned(
              child: Text(
                message,
                textAlign: TextAlign.start,
                style: theme.labelSmall!.copyWith(
                  color:
                      sendByMe ? AppColors.lightGrey : AppColors.primaryColor,
                  // fontWeight: Fontw
                ),
              ),
            ),
            SizedBox(height: 1.w),
            Text(
              sendByMe ? time.toString() : time.toString(),
              style: sendByMe
                  ? theme.bodySmall!
                      .copyWith(fontSize: 8.sp, color: AppColors.white)
                  : theme.bodySmall!
                      .copyWith(fontSize: 8.sp, color: AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}
