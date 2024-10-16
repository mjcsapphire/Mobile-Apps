import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:triple_g/core/utils/colors.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  RxList<types.Message> messages = <types.Message>[].obs;
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.h),
        child: Container(
          height: 20.h,
          margin: EdgeInsets.only(top: 5.h, left: 8.w, right: 8.w),
          decoration: const BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.white,
                blurRadius: 30,
                spreadRadius: 30,
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primaryColor,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cathrine',
                    style: textTheme.titleLarge!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'online',
                    style: textTheme.bodyMedium!.copyWith(
                      color: AppColors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 5.h)
            ],
          ),
        ),
      ),
      body: Obx(() => Chat(
            emojiEnlargementBehavior: EmojiEnlargementBehavior.multi,
            messageWidthRatio: 0.8,
            messages: messages.reversed.toList(),
            dateHeaderThreshold: 24 * 60 * 60 * 60,
            theme: DefaultChatTheme(
              inputTextCursorColor: AppColors.primaryColor,
              inputSurfaceTintColor: Colors.yellow,
              inputBackgroundColor: AppColors.scaffoldColor,
              backgroundColor: AppColors.scaffoldColor,
              inputTextColor: AppColors.scaffoldColor,
              inputPadding: EdgeInsets.zero,
              inputTextStyle: const TextStyle(
                color: Colors.black,
              ),
              primaryColor: AppColors.primaryColor,
              messageMaxWidth: 100.w,
            ),
            dateFormat: DateFormat('HH:mm'),
            dateIsUtc: false,
            customDateHeaderText: (p0) => DateFormat('yMMMd').format(p0),
            textMessageOptions: const TextMessageOptions(
              isTextSelectable: true,
            ),
            // showUserAvatars: true,
            bubbleRtlAlignment: BubbleRtlAlignment.left,
            bubbleBuilder: (child,
                {required message, required nextMessageInGroup}) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.author.id == "1")
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/300?u=1234567890',
                      ),
                    ),
                  SizedBox(width: 2.w),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 71.w),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          // height: 8.h,
                          decoration: BoxDecoration(
                            color: message.author.id == "1"
                                ? Colors.white
                                : AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: child,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 0.5.w,
                            horizontal: 2.w,
                          ),
                          child: Text(
                            "19:00",
                            style: textTheme.labelLarge!.copyWith(
                              color: message.author.id != "1"
                                  ? Colors.white
                                  : AppColors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 2.w),
                  if (message.author.id != "1")
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/300?u=1234567891',
                      ),
                    ),
                ],
              );
            },
            customBottomWidget: Container(
              height: 10.h,
              width: 100.w,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 1,
                            color: AppColors.labelColor,
                          )),
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Message...",
                          hintStyle: textTheme.bodyMedium!.copyWith(
                            color: AppColors.labelColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  GestureDetector(
                    onTap: () {
                      messages.add(types.TextMessage(
                        id: Random().nextInt(99999999).toString(),
                        author: types.User(id: Random().nextInt(2).toString()),
                        text: messageController.text,
                      ));
                      messageController.clear();
                    },
                    child: Container(
                      height: 6.h,
                      width: 6.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onSendPressed: (value) {
              types.TextMessage(
                author: types.User(id: messageController.value.text),
                id: value.text,
                text: value.text,
              );
              // chatController.messages.add(message);
            },
            user: const types.User(
              id: '0',
            ),
          )),
    );
  }
}
