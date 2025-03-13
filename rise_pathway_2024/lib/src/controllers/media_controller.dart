import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/environment.dart';
import 'package:rise_pathway/services/rise_media_service.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
import 'package:rise_pathway/src/models/risebutton/audio_response.dart';

class MediaController extends GetxController {
  final Dio dio;

  MediaController({required this.dio});

  late final mediaService = RiseMediaService(dio: dio);
  final authController = Get.find<AuthController>();

  final AudioPlayer audioPlayer = AudioPlayer();

  var mediaList = <dynamic>[].obs;

  Rx<AudioResponse?> selectedAudio = Rx<AudioResponse?>(null);
  Rx<String?> selectedGif = Rx<String?>(null);

  RxBool isPlaying = false.obs;
  var duration = Rx<Duration>(Duration.zero);
  RxDouble progress = 0.0.obs;

  // Define local GIFs list
  final List<String> localGifs = [
    "assets/media/river.gif",
    "assets/media/waterfall.gif",
    "assets/media/sunset.gif",
  ];

  @override
  void onInit() {
    super.onInit();
    fetchMedia();
  }

  Future<void> fetchMedia() async {
    final audioResult = await mediaService.fetchAudios();

    audioResult.fold(
      (failure) => logger.e("Error fetching audio: $failure"),
      (audios) => mediaList.addAll(audios),
    );

    // Add local GIFs to mediaList
    mediaList.addAll(localGifs);
  }

  /// Select audio
  Future<void> selectAudio(AudioResponse audio) async {
    stopMedia();
    selectedAudio.value = audio;
    await _loadAudio(audio.path);
  }

  /// Select GIF
  Future<void> selectGif(String gifPath) async {
    stopMedia();
    selectedGif.value = gifPath;
  }

  /// Play both media together
  void playSelectedMedia() {
    if (selectedAudio.value != null && selectedGif.value != null) {
      audioPlayer.play();
      isPlaying.value = true;
    } else {
      logger.e("Both audio and GIF must be selected!");
    }
  }

  Future<void> _loadAudio(String url) async {
    final fullUrl = "${Environment.mediaImageUrl}$url";
    try {
      await audioPlayer.setUrl(fullUrl);
      await audioPlayer.play();
      _setupProgressTracking();
      audioPlayer.setLoopMode(LoopMode.one);
    } catch (e) {
      logger.e("Error loading audio: $e");
    }
  }

  void _setupProgressTracking() {
    audioPlayer.positionStream.listen((position) {
      final totalDuration = audioPlayer.duration ?? Duration.zero;
      if (totalDuration.inMilliseconds > 0) {
        progress.value = position.inMilliseconds / totalDuration.inMilliseconds;
      } else {
        progress.value = 0.0;
      }
    });
  }

  Future<void> seekTo(double progressValue) async {
    final totalDuration = audioPlayer.duration ?? Duration.zero;
    final newPosition = Duration(
        milliseconds: (totalDuration.inMilliseconds * progressValue).toInt());

    if (totalDuration > Duration.zero) {
      await audioPlayer.seek(newPosition);
    }
  }

  void stopMedia() {
    audioPlayer.stop();
    isPlaying.value = false;
    progress.value = 0.0;
  }

  // set user image video
  Future<void> setUserImageVideo(String email, String path) async {
    try {
      await mediaService.setUserImageVideo(email: email, path: path);
    } catch (e) {
      logger.e("Error setting user image video: $e");
    }
  }

  // set user audio
  Future<void> setUserAudio(String email, String path) async {
    try {
      await mediaService.setUserAudio(email: email, path: path);
    } catch (e) {
      logger.e("Error setting user audio: $e");
    }
  }
}



// class MediaController extends GetxController {
//   final Dio dio;
//   MediaController({required this.dio});

//   late final mediaService = RiseMediaService(dio: dio);
//   final AuthController authController = Get.find<AuthController>();

//   final AudioPlayer audioPlayer = AudioPlayer();
//   VideoPlayerController? videoPlayer;

//   var mediaList = <dynamic>[].obs;
//   Rx<AudioResponse?> selectedAudio = Rx<AudioResponse?>(null);
//   Rx<VideoResponse?> selectedVideo = Rx<VideoResponse?>(null);
//   RxBool videoPlayerInitialized = false.obs;
//   // Rx<Duration> currentPosition = Duration.zero.obs;
//   // Rx<Duration> totalDuration = Duration.zero.obs;

//   RxBool isPlaying = false.obs;
//   RxDouble progress = 0.0.obs;
//   String baseUrl = Environment.mediaImageUrl;

//   String? mergedVideoPath;
//   String? audioFilePath;
//   String? videoFilePath;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchMedia();
//   }

//   @override
//   void onClose() {
//     audioPlayer.dispose();
//     videoPlayer?.dispose();
//     super.onClose();
//   }

//   /// Fetch available media
//   Future<void> fetchMedia() async {
//     try {
//       final audioResult = await mediaService.fetchAudios();
//       final videoResult = await mediaService.fetchVideos();

//       audioResult.fold(
//         (failure) => logger.d("Error fetching audio: $failure"),
//         (audios) => mediaList.addAll(audios),
//       );

//       videoResult.fold(
//         (failure) => logger.d("Error fetching video: $failure"),
//         (videos) => mediaList.addAll(videos),
//       );
//     } catch (e) {
//       logger.d("Error fetching media: $e");
//     }
//   }

//   /// Select audio
//   Future<void> selectAudio(AudioResponse audio) async {
//     try {
//       _deleteMergedMedia(); // Delete previous merged media
//       // _deleteFile(audioFilePath);
//       selectedAudio.value = audio;
//       audioFilePath =
//           await _downloadFileIfNeeded("$baseUrl${audio.path}", "audio.mp3");
//     } catch (e) {
//       logger.d("Error selecting audio: $e");
//     }
//   }

//   /// Select video
//   // Future<void> selectVideo(VideoResponse video) async {
//   //   try {
//   //     _deleteMergedMedia(); // Delete previous merged media
//   //     _deleteFile(videoFilePath);
//   //     selectedVideo.value = video;
//   //     videoFilePath =
//   //         await _downloadFileIfNeeded("$baseUrl${video.path}", "video.mp4");
//   //   } catch (e) {
//   //     logger.d("Error selecting video: $e");
//   //   }
//   // }

//   // void _deleteFile(String? filePath) {
//   //   if (filePath != null && File(filePath).existsSync()) {
//   //     File(filePath).deleteSync();
//   //     logger.d("🗑️ Deleted old file: $filePath");
//   //   }
//   // }

//   /// Merge audio & video using FFmpeg
//   // Future<void> mergeMedia() async {
//   //   if (audioFilePath == null || videoFilePath == null) {
//   //     logger.d("❌ No valid media selected for merging.");
//   //     return;
//   //   }

//   //   _deleteMergedMedia(); // Ensure previous merged media is deleted

//   //   final dir = await getApplicationDocumentsDirectory();
//   //   mergedVideoPath = "${dir.path}/merged_video.mp4";

//   //   final ffmpegCommand =
//   //       '-i "$videoFilePath" -i "$audioFilePath" -c:v copy -c:a aac -strict experimental "$mergedVideoPath"';

//   //   try {
//   //     await FFmpegKit.execute(ffmpegCommand).then((session) async {
//   //       final returnCode = await session.getReturnCode();
//   //       final output = await session.getOutput();
//   //       final logs = await session.getLogsAsString();

//   //       if (ReturnCode.isSuccess(returnCode)) {
//   //         logger.d("✅ Media merged successfully: $mergedVideoPath");
//   //         await _loadVideo(mergedVideoPath!);
//   //       } else {
//   //         logger.d("❌ FFmpeg failed: $output");
//   //         logger.d("🔍 FFmpeg logs: $logs");
//   //       }
//   //     });
//   //   } catch (e) {
//   //     logger.d("Error merging media: $e");
//   //   }
//   // }

//   /// Play merged media
//   // Future<void> playMergedMedia() async {
//   //   if (mergedVideoPath == null || !File(mergedVideoPath!).existsSync()) {
//   //     logger.d("❌ Merged video is not available.");
//   //     return;
//   //   }

//   //   try {
//   //     logger.i("🎬 Playing merged video: $mergedVideoPath");
//   //     await _loadVideo(mergedVideoPath!);
//   //     videoPlayer?.play();
//   //     isPlaying.value = true;
//   //   } catch (e) {
//   //     logger.d("Error playing merged media: $e");
//   //   }
//   // }

//   /// Stop video
//   Future<void> stopVideo() async {
//     try {
//       videoPlayer?.pause();
//       isPlaying.value = false;
//     } catch (e) {
//       logger.d("Error stopping video: $e");
//     }
//   }

//   /// Load video
//   // Future<void> _loadVideo(String path) async {
//   //   try {
//   //     videoPlayer?.dispose();
//   //     videoPlayer = VideoPlayerController.file(File(path));

//   //     await videoPlayer!.initialize();
//   //     videoPlayer!.setLooping(true);
//   //     videoPlayerInitialized.value = true;
//   //     _setupProgressTracking();

//   //     update();
//   //   } catch (error) {
//   //     logger.d("Error initializing video: $error");
//   //   }
//   // }

//   /// Set up progress tracking for the video player
//   void _setupProgressTracking() {
//     if (videoPlayer == null) return;

//     // Listen to video position changes
//     videoPlayer!.addListener(() {
//       if (videoPlayer!.value.isInitialized) {
//         // Calculate progress as a value between 0.0 and 1.0
//         final duration = videoPlayer!.value.duration;
//         final position = videoPlayer!.value.position;

//         if (duration.inMilliseconds > 0) {
//           progress.value = position.inMilliseconds / duration.inMilliseconds;
//         }
//       }
//     });
//   }

//   /// Seek to a specific position in the video
//   Future<void> seekTo(double progressValue) async {
//     if (videoPlayer != null && videoPlayer!.value.isInitialized) {
//       final duration = videoPlayer!.value.duration;
//       final newPosition = duration * progressValue;
//       await videoPlayer!.seekTo(newPosition);
//     }
//   }

//   /// Download file only if it doesn't already exist
//   // Future<String?> _downloadFileIfNeeded(String url, String fileName) async {
//   //   final dir = await getApplicationDocumentsDirectory();
//   //   final filePath = "${dir.path}/$fileName";

//   //   // Delete the file if it already exists
//   //   _deleteFile(filePath);

//   //   return await _downloadFile(url, filePath);
//   // }

//   // /// Download file from URL
//   // Future<String?> _downloadFile(String url, String savePath) async {
//   //   try {
//   //     logger.d("Downloading: $url -> $savePath");
//   //     final response = await dio.download(url, savePath);

//   //     if (response.statusCode == 200) {
//   //       logger.d("Download successful: $savePath");
//   //       return savePath;
//   //     } else {
//   //       logger.d("Download failed: HTTP ${response.statusCode}");
//   //       return null;
//   //     }
//   //   } catch (e) {
//   //     logger.d("Download error: $e");
//   //     return null;
//   //   }
//   // }

//   // /// Delete previously merged media file and reset video player
//   // void _deleteMergedMedia() {
//   //   if (mergedVideoPath != null) {
//   //     final file = File(mergedVideoPath!);
//   //     if (file.existsSync()) {
//   //       file.deleteSync();
//   //       logger.d("🗑️ Deleted previous merged media: $mergedVideoPath");
//   //     }
//   //   }
//   //   mergedVideoPath = null;

//   //   // Dispose of video player if it exists
//   //   videoPlayer?.dispose();
//   //   videoPlayer = null;
//   //   videoPlayerInitialized.value = false;
//   // }
// }
