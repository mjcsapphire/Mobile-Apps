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
  CachedVideoPlayerPlusController? videoPlayer;

  var mediaList = <dynamic>[].obs;

  Rx<AudioResponse?> selectedAudio = Rx<AudioResponse?>(null);
  Rx<VideoResponse?> selectedVideoImage = Rx<VideoResponse?>(null);

  RxBool isPlaying = false.obs;
  var duration = Rx<Duration>(Duration.zero);
  RxDouble progress = 0.0.obs;
  String baseUrl = Environment.mediaImageUrl;

  @override
  void onInit() {
    super.onInit();
    fetchMedia();
  }

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

  /// Select audio
  Future<void> selectAudio(AudioResponse audio) async {
    stopMedia();
    selectedAudio.value = audio;
    await _loadAudio(audio.path);
  }

  /// Select video/image
  Future<void> selectVideoImage(VideoResponse video) async {
    stopMedia();
    selectedVideoImage.value = video;
    _loadVideo(video.path);
  }

  /// Play both media together
  void playSelectedMedia() {
    if (selectedAudio.value != null && selectedVideoImage.value != null) {
      audioPlayer.play();
      videoPlayer?.play();
      isPlaying.value = true;
    } else {
      logger.e("Both audio and video/image must be selected!");
    }
  }

  Future<void> _loadAudio(String url) async {
    String fullUrl = "$baseUrl$url";
    try {
      await audioPlayer.setUrl(fullUrl);
      await audioPlayer.play();
      audioPlayer.setLoopMode(LoopMode.one);
    } catch (e) {
      logger.e("Error loading audio: $e");
    }
  }

  void _loadVideo(String url) {
    String fullUrl = "$baseUrl$url";
    videoPlayer = CachedVideoPlayerPlusController.networkUrl(Uri.parse(fullUrl))
      ..initialize().then((_) {
        videoPlayer!.setLooping(true);
        videoPlayer!.play();
      }).catchError((error) {
        logger.e("Error initializing video: $error");
      });
  }

  void stopMedia() {
    audioPlayer.stop();
    videoPlayer?.pause();
    videoPlayer?.seekTo(Duration.zero);
    isPlaying.value = false;
    progress.value = 0.0;
  }
}
