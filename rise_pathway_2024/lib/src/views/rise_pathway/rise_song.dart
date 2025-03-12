import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
import 'package:rise_pathway/src/controllers/media_controller.dart';
import 'package:rise_pathway/src/models/risebutton/audio_response.dart';
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
        return Column(
          children: [
            const SizedBox(height: 10),
            Text("Select an Audio", style: theme.titleMedium),
            _buildAudioList(),
            const Divider(),
            Text("Select a GIF", style: theme.titleMedium),
            _buildGifList(),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue800,
                  foregroundColor: AppColors.white,
                  padding:
                      EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 20.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
              onPressed: musicController.selectedAudio.value != null &&
                      musicController.selectedGif.value != null
                  ? () {
                      musicController.playSelectedMedia();
                      context.pop();
                    }
                  : null,
              child: const RiseText("Rise Now"),
            ),
            SizedBox(height: 5.h)
          ],
        );
      }),
    );
  }

  Widget _buildAudioList() {
    final audioList =
        musicController.mediaList.whereType<AudioResponse>().toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: audioList.length,
      itemBuilder: (context, index) {
        final audio = audioList[index];
        bool isSelected = musicController.selectedAudio.value == audio;

        return ListTile(
          leading: const Icon(Icons.audiotrack, color: AppColors.secondryColor),
          title: Text(audio.title),
          subtitle: const Text("Audio"),
          trailing: isSelected
              ? const Icon(Icons.check, color: AppColors.primaryColor)
              : null,
          onTap: () {
            musicController.selectAudio(audio);
            musicController.setUserImageVideo(
                authController.userData.value.userEmail!, audio.path);
          },
        );
      },
    );
  }

  Widget _buildGifList() {
    final gifList = musicController.localGifs;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: gifList.length,
      itemBuilder: (context, index) {
        final gifPath = gifList[index];
        bool isSelected = musicController.selectedGif.value == gifPath;

        return ListTile(
          leading: Image.asset(
            gifPath,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(Helpers.getFileName(gifPath)),
          subtitle: const Text("GIF"),
          trailing: isSelected
              ? const Icon(Icons.check, color: AppColors.primaryColor)
              : null,
          onTap: () {
            musicController.selectGif(gifPath);
            // musicController.setUserImageVideo(
            //     authController.userData.value.userEmail!, gifPath);
          },
        );
      },
    );
  }
}
