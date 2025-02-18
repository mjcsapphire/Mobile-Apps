import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rise_pathway/core/constants/config.dart';
import 'package:rise_pathway/core/errors/failures.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/api_services.dart';
import 'package:rise_pathway/src/models/risebutton/audio_response.dart';
import 'package:rise_pathway/src/models/risebutton/video_response.dart';

class RiseMediaService {
  final Dio dio;
  RiseMediaService({required this.dio});

  Future<Either<Failure, List<AudioResponse>>> fetchAudios() async {
    try {
      final response = await ApiServices.sendRequest(
          dio, RequestType.get, Config.fetchToolKit,
          headers: {"Content-Type": "application/json"},
          queryParams: {"type": 1});

      List<AudioResponse> audios = [];
      if (response != null) {
        for (var element in response) {
          audios.add(AudioResponse.fromJson(element));
        }
      }
      return Right(audios);
    } catch (e) {
      logger.e(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<VideoResponse>>> fetchVideos() async {
    try {
      final response = await ApiServices.sendRequest(
          dio, RequestType.get, Config.fetchToolKit,
          headers: {"Content-Type": "application/json"},
          queryParams: {"type": 2});

      List<VideoResponse> videos = [];
      if (response != null) {
        for (var element in response) {
          videos.add(VideoResponse.fromJson(element));
        }
      }
      return Right(videos);
    } catch (e) {
      logger.e(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
