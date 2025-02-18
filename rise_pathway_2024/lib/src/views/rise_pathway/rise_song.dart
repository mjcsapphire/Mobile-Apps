import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/media_controller.dart';
import 'package:rise_pathway/src/models/risebutton/audio_response.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';

class SongListScreen extends StatelessWidget {
  final List<AudioResponse> songs; // Ensure it's a list of AudioResponse

  SongListScreen({super.key, required this.songs});

  final musicController = Get.find<MediaController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: 'Select Sounds',
        onTap: () => context.pop(),
      ),
      body: Obx(() {
        final mediaList = musicController.mediaList;

        return ListView.builder(
          shrinkWrap: true,
          itemCount: mediaList.length,
          itemBuilder: (context, index) {
            final media = mediaList[index];

            return ListTile(
              leading: media is AudioResponse
                  ? const Icon(Icons.audiotrack, color: AppColors.secondryColor)
                  : const Icon(Icons.videocam, color: AppColors.primaryColor),
              title: Text(media.title),
              subtitle: media is AudioResponse
                  ? const Text("Audio")
                  : const Text("Video"),
              trailing: musicController.selectedMedia.value == media
                  ? const Icon(Icons.check, color: AppColors.primaryColor)
                  : null,
              onTap: () {
                musicController.selectMedia(media);
                context.pop();
              },
            );
          },
        );
      }),
    );
  }
}
