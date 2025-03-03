import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
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
  final authController = Get.find<AuthController>();
  final isTextFieldEmpty = false.obs;

  @override
  void initState() {
    super.initState();
    chatController.getMessages(
        email: authController.userData.value.userEmail!, limit: 100, offset: 0);
  }

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
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RiseText('Stephen Allen',
                    style: theme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    )),
                // RiseText('Active now',
                //     style: theme.bodySmall!.copyWith(fontSize: 10)),
              ],
            )
          ],
        ),
      ),
      body: Obx(() {
        return Chat(
          emojiEnlargementBehavior: EmojiEnlargementBehavior.multi,
          messageWidthRatio: 0.8,
          dateHeaderThreshold: 24 * 60 * 60 * 60,
          messages: chatController.chats.map((chat) {
            return types.TextMessage(
              author: types.User(id: chat.id!),
              id: chat.id!,
              text: chat.message!,
              createdAt: DateTime.parse(chat.dateSent!.toString())
                  .toLocal()
                  .millisecondsSinceEpoch,
            );
          }).toList(),
          user: const types.User(id: '0'),
          onSendPressed: (value) {
            if (value.text.isNotEmpty) {
              chatController.sendMessage(
                  email: authController.userData.value.userEmail!,
                  message: value.text);
              messageController.value.clear();
              isTextFieldEmpty.value = false;
            }
          },
          theme: const DefaultChatTheme(
            inputBackgroundColor: Colors.white,
            primaryColor: AppColors.chatMessageColor,
          ),
          dateIsUtc: false,
          avatarBuilder: (author) => const CircleAvatar(),
          dateFormat: DateFormat('HH:mm'),
          customDateHeaderText: (p0) => DateFormat('yMMMd').format(p0),
          textMessageOptions: const TextMessageOptions(
            isTextSelectable: true,
          ),
          bubbleBuilder: (child,
              {required message, required nextMessageInGroup}) {
            return MessageTile(
              message: (child as TextMessage).message.text,
              sendByMe: true,
              icon: Icons.check_sharp,
            );
          },
          customBottomWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            child: Obx(
              () => Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      String? emoji = await Helpers.pickEmoji(context);
                      if (emoji != null) {
                        messageController.value = TextEditingController(
                          text: messageController.value.text + emoji,
                        );
                        isTextFieldEmpty.value = true;

                        chatController.sendMessage(
                            email: authController.userData.value.userEmail!,
                            message: messageController.value.text);
                        messageController.value.clear();
                        isTextFieldEmpty.value = false;
                        chatController.getMessages(
                            email: authController.userData.value.userEmail!,
                            limit: 100,
                            offset: 0);
                      }
                    },
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
                        hintText: 'Type a message',
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
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          isTextFieldEmpty.value = true;
                        } else {
                          isTextFieldEmpty.value = false;
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _showMediaBottomSheet(context);
                    },
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
                        if (!isTextFieldEmpty.value) {
                          EasyLoading.showToast('Message can\'t be empty');
                          return;
                        }
                        // final types.TextMessage message = types.TextMessage(
                        //   author: const types.User(id: '0'),
                        //   id: Random().nextInt(100000).toString(),
                        //   text: messageController.value.text,
                        //   createdAt: DateTime.now().millisecondsSinceEpoch,
                        //   showStatus: true,
                        //   status: types.Status.delivered,
                        // );
                        // chatController.messages.add(message);
                        // messageController.value.clear();

                        chatController.sendMessage(
                            email: authController.userData.value.userEmail!,
                            message: messageController.value.text);
                        messageController.value.clear();
                        isTextFieldEmpty.value = false;
                        chatController.getMessages(
                            email: authController.userData.value.userEmail!,
                            limit: 100,
                            offset: 0);
                      },
                      color: AppColors.primaryColor,
                      icon: Obx(
                        () => Icon(
                          isTextFieldEmpty.value ? Icons.send : Icons.mic,
                          size: 2.5.h,
                          color: AppColors.white,
                          fill: .1,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _showMediaBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text("Camera"),
                onTap: () => Helpers.pickImage(ImageSource.camera)),
            ListTile(
                leading: const Icon(Icons.image, color: Colors.green),
                title: const Text("Gallery"),
                onTap: () => Helpers.pickImage(ImageSource.gallery)),
            ListTile(
                leading:
                    const Icon(Icons.insert_drive_file, color: Colors.orange),
                title: const Text("Documents"),
                onTap: () async {
                  final file = await Helpers.pickFile();
                  if (file != null) {
                    print(file.path);
                  }
                }),
          ],
        );
      },
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final IconData? icon;

  const MessageTile({
    super.key,
    required this.message,
    required this.sendByMe,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: sendByMe ? 30 : 10,
            right: sendByMe ? 10 : 20),
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
            RiseText(
              message,
              textAlign: TextAlign.start,
              style: theme.labelSmall!.copyWith(
                color: sendByMe ? AppColors.lightGrey : AppColors.primaryColor,
                // fontWeight: Fontw
              ),
            ),
            SizedBox(height: 1.w),
            // RiseText(
            //   sendByMe ? '' : '',
            //   style: sendByMe
            //       ? theme.bodySmall!
            //           .copyWith(fontSize: 8.sp, color: AppColors.white)
            //       : theme.bodySmall!
            //           .copyWith(fontSize: 8.sp, color: AppColors.black),
            // ),
            Icon(
              sendByMe ? icon : null,
              color: AppColors.white,
              size: 10.sp,
            )
          ],
        ),
      ),
    );
  }
}
