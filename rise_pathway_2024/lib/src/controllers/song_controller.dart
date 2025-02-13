import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rise_pathway/src/dummy_song.dart';

class MusicController extends GetxController {
  final AudioPlayer player = AudioPlayer();
  var selectedSong = Rxn<Map<String, String>>();
  var isPlaying = false.obs;
  var duration = Rx<Duration?>(const Duration());
  var progress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    if (songs.isNotEmpty) {
      selectedSong.value = songs[0];
    }
  }

  void selectSong(Map<String, String> song) async {
    selectedSong.value = song;
    await playSong(song["song_url"]!);
  }

  Future<void> playSong(String url) async {
    if (isPlaying.value) {
      await player.stop();
      isPlaying.value = false;
    }

    await player.setLoopMode(LoopMode.one);
    duration.value = await player.setAsset(url);

    player.createPositionStream().listen((event) {
      if (duration.value != null) {
        progress.value = event.inMilliseconds / duration.value!.inMilliseconds;
      }
    });

    await player.play();
    isPlaying.value = true;
  }

  void togglePlayPause() async {
    if (isPlaying.value) {
      await player.pause();
    } else {
      await player.play();
    }
    isPlaying.toggle();
  }

  void stopMusic() async {
    await player.stop();
    isPlaying.value = false;
    progress.value = 0.0;
  }

  void seekTo(double value) {
    final newPosition = Duration(
        milliseconds: (value * duration.value!.inMilliseconds).toInt());
    player.seek(newPosition);
  }
}
