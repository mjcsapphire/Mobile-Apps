import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/song_controller.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';

class SongListScreen extends StatelessWidget {
  final List<Map<String, String>> songs;

  SongListScreen({super.key, required this.songs});

  final musicController = Get.find<MusicController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: 'Select Sounds',
        onTap: () => context.pop(),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return ListTile(
            leading: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.blue600, width: 2),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(song["thumbnail"] ?? ""),
                foregroundColor: AppColors.blue400,
                radius: 40,
              ),
            ),
            title: Text(song["title"] ?? "Unknown", style: theme.bodyLarge),
            subtitle: Text(song["duration"] ?? "", style: theme.bodyLarge),
            onTap: () {
              musicController.selectSong(song);
              context.pop();
            },
            trailing: musicController.selectedSong.value != null &&
                    musicController.selectedSong.value!["id"] == song["id"]
                ? Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: Icon(
                      Icons.play_arrow,
                      color: AppColors.blue900,
                      size: 6.5.w,
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}
