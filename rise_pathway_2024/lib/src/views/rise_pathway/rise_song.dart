import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
import 'package:rise_pathway/src/controllers/media_controller.dart';
import 'package:rise_pathway/src/models/risebutton/audio_response.dart';
import 'package:rise_pathway/src/models/risebutton/video_response.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';

class SongListScreen extends StatelessWidget {
  final List<AudioResponse> songs;

  SongListScreen({super.key, required this.songs});

  final musicController = Get.find<MediaController>();
  final authController = Get.find<AuthController>();

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

        return Column(
          children: [
            const SizedBox(height: 10),
            Text("Select an Audio", style: theme.titleMedium),
            _buildMediaList(mediaList.whereType<AudioResponse>().toList(),
                isAudio: true),
            const Divider(),
            Text("Select a Video/Image", style: theme.titleMedium),
            _buildMediaList(mediaList.whereType<VideoResponse>().toList(),
                isAudio: false),
            const Spacer(),
            ElevatedButton(
              onPressed: musicController.selectedAudio.value != null &&
                      musicController.selectedGif.value != null
                  ? () {
                      musicController.playSelectedMedia();
                      context.pop();
                    }
                  : null,
              child: const Text("Rise"),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMediaList(List<dynamic> mediaList, {required bool isAudio}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: mediaList.length,
      itemBuilder: (context, index) {
        final media = mediaList[index];
        bool isSelected = isAudio
            ? musicController.selectedAudio.value == media
            : musicController.selectedGif.value == media;

        return ListTile(
          leading: isAudio
              ? const Icon(Icons.audiotrack, color: AppColors.secondryColor)
              : Image.asset(
                  media,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
          title: Text(isAudio ? media.title : "GIF ${index + 1}"),
          subtitle: Text(isAudio ? "Audio" : "GIF"),
          trailing: isSelected
              ? const Icon(Icons.check, color: AppColors.primaryColor)
              : null,
          onTap: () {
            if (isAudio) {
              musicController.selectAudio(media);
            } else {
              musicController.selectGif(media);
            }
          },
        );
      },
    );
  }
}
