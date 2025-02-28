import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rise_pathway/core/constants/config.dart';
import 'package:rise_pathway/core/errors/failures.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/api_services.dart';
import 'package:rise_pathway/src/models/meeting/get_meeting_model.dart';
import 'package:rise_pathway/src/models/meeting/time_slot_model.dart';

class MeetingServices {
  final Dio dio;

  MeetingServices({required this.dio});

// get available time slots
  Future<Either<Failure, List<TimeSlot>>> getAvailableTimeSlots(
      {required String email, required String date}) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.get,
        Config.getAvailableTimes,
        headers: {"Content-Type": "application/json"},
        queryParams: {"email": email, "date": date},
      );

      List<TimeSlot> timeSlots = [];

      if (response != null) {
        for (var element in response) {
          timeSlots.add(TimeSlot.fromJson(element));
        }
      }

      return Right(timeSlots);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

// book a meeting
  Future<Either<Failure, List<dynamic>>> bookMeeting({
    required String email,
    required String date,
    required String time,
  }) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.post,
        Config.makeBooking,
        headers: {"Content-Type": "application/json"},
        queryParams: {"email": email, "date": date, "time": time},
      );

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // get bookings
  Future<Either<Failure, List<GetMeetingResponse>>> getBookings(
      {required String email}) async {
    try {
      final response = await ApiServices.sendRequest(
          dio, RequestType.get, Config.getBookings,
          headers: {"Content-Type": "application/json"},
          queryParams: {"email": email});

      List<GetMeetingResponse> meetings = [];

      if (response != null) {
        for (var element in response) {
          meetings.add(GetMeetingResponse.fromJson(element));
        }
      }

      return Right(meetings);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // cancel Meeting
  Future<Either<Failure, List<dynamic>>> cancelBooking(
      {required String email, required int id}) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.post,
        Config.cancelBooking,
        headers: {"Content-Type": "application/json"},
        queryParams: {"email": email, "id": id},
      );

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
