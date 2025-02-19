import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/environment.dart';
import 'package:rise_pathway/services/rise_media_service.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
import 'package:rise_pathway/src/models/risebutton/audio_response.dart';
import 'package:rise_pathway/src/models/risebutton/video_response.dart';

class MediaController extends GetxController {
  final Dio dio;

  MediaController({required this.dio});

  late final mediaService = RiseMediaService(dio: dio);
  final authController = Get.find<AuthController>();

  final AudioPlayer audioPlayer = AudioPlayer();
  // VideoPlayerController? videoPlayer;
  CachedVideoPlayerPlusController? videoPlayer;

  /// Combined Media List (Audio & Video)
  var mediaList = <dynamic>[].obs;

  /// Selected Media
  RxBool isAudio = false.obs;

  /// Playback states
  RxBool isPlaying = false.obs;
  var duration = Rx<Duration>(Duration.zero);
  RxDouble progress = 0.0.obs;
  String baseUrl = Environment.mediaImageUrl;
  var selectedMedia = Rx<dynamic>(null);

  @override
  void onInit() {
    super.onInit();
    fetchMedia();
    selectedMedia.value = authController.userData.value.riseSound;
  }

  /// Fetch media from API
  Future<void> fetchMedia() async {
    final audioResult = await mediaService.fetchAudios();
    final videoResult = await mediaService.fetchVideos();

    audioResult.fold(
      (failure) => logger.e("Error fetching audio: $failure"),
      (audios) => mediaList.addAll(audios),
    );

    videoResult.fold(
      (failure) => logger.e("Error fetching video: $failure"),
      (videos) => mediaList.addAll(videos),
    );
  }

  /// Select and play media
  Future<void> selectMedia(dynamic media) async {
    stopMedia();
    selectedMedia.value = media;

    if (media is AudioResponse) {
      isAudio.value = true;
      await _loadAudio(media.path);
      playMedia();
    } else if (media is VideoResponse) {
      isAudio.value = false;
      _loadVideo(media.path);
      playMedia();
    }
  }

  /// Play media based on type (Audio or Video)
  void playMedia() {
    if (isAudio.value) {
      audioPlayer.play();
    } else {
      videoPlayer?.play();
    }
    isPlaying.value = true;
  }

  /// Load and play audio
  Future<void> _loadAudio(String url) async {
    String fullUrl = "$baseUrl$url";
    try {
      await audioPlayer.setUrl(fullUrl);
      duration.value = audioPlayer.duration ?? Duration.zero;
      isPlaying.value = true;
      await audioPlayer.play();
      audioPlayer.setLoopMode(LoopMode.one);
      audioPlayer.durationStream.listen((d) {
        if (d != null) duration.value = d;
      });

      audioPlayer.positionStream.listen((p) {
        progress.value = p.inMilliseconds / (duration.value.inMilliseconds + 1);
      });
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  /// Load and play video
  void _loadVideo(String url) {
    String fullUrl = "$baseUrl$url";
    videoPlayer = CachedVideoPlayerPlusController.networkUrl(Uri.parse(fullUrl))
      ..initialize().then((_) {
        videoPlayer!.setLooping(true);
        videoPlayer!.play();
        playMedia();
        duration.value = videoPlayer!.value.duration;
        togglePlayPause();
        update();
      });

    videoPlayer!.addListener(() {
      progress.value = videoPlayer!.value.position.inMilliseconds /
          (videoPlayer!.value.duration.inMilliseconds + 1);
    });
  }

  /// Play or Pause Media
  void togglePlayPause() {
    if (isAudio.value) {
      audioPlayer.playing ? audioPlayer.pause() : audioPlayer.play();
    } else {
      videoPlayer!.value.isPlaying ? videoPlayer!.pause() : videoPlayer!.play();
    }
    isPlaying.toggle();
  }

  /// Stop Media
  void stopMedia() {
    if (isAudio.value) {
      audioPlayer.stop();
    } else {
      videoPlayer?.pause();
      videoPlayer?.seekTo(Duration.zero);
    }
    isPlaying.value = false;
    progress.value = 0.0;
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    videoPlayer?.dispose();
    super.onClose();
  }

  Future<void> updateUserMedia({required String email}) async {
    if (selectedMedia.value is VideoResponse) {
      final successOrFailure = await mediaService.setUserImageVideo(
          email: email, path: selectedMedia.value.path);

      successOrFailure.fold(
        (failure) => logger.e(failure),
        (success) {
          logger.d("Successfully updated media: $success");
        },
      );
    } else {
      final successOrFailure = await mediaService.setUserAudio(
          email: email, path: selectedMedia.value.path);
      successOrFailure.fold(
        (failure) => logger.e(failure),
        (success) {
          logger.d("Successfully updated media: $success");
        },
      );
    }
  }
}
