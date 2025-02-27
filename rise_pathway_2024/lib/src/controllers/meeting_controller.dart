import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/meeting_services.dart';
import 'package:rise_pathway/src/models/meeting/get_meeting_model.dart';
import 'package:rise_pathway/src/models/meeting/time_slot_model.dart';

class MeetingController extends GetxController {
  final Dio dio;

  MeetingController({required this.dio});

  late final _services = MeetingServices(dio: dio);

  final timeSlots = <TimeSlot>[].obs;
  final isLoading = false.obs;
  final meetings = <GetMeetingResponse>[].obs;
  final filteredMeetings = <GetMeetingResponse>[].obs;

  Future<void> getAvailableTimeSlots({
    required String email,
    required String date,
  }) async {
    isLoading.value = true;
    final successOrFailure =
        await _services.getAvailableTimeSlots(email: email, date: date);
    successOrFailure.fold(
      (failure) => logger.e(failure),
      (response) {
        timeSlots.clear();
        timeSlots.addAll(response);
      },
    );
    isLoading.value = false;
  }

  // book meeting
  Future<void> bookMeeting({
    required String email,
    required String date,
    required String time,
  }) async {
    isLoading.value = true;
    final successOrFailure = await _services.bookMeeting(
      email: email,
      date: date,
      time: time,
    );
    successOrFailure.fold((failure) => logger.e(failure), (response) {
      Helpers.toast('Meeting booked successfully');
      return logger.i(response);
    });
    isLoading.value = false;
  }

  // get meetings

  Future<void> getBookings({required String email}) async {
    isLoading.value = true;
    final successOrFailure = await _services.getBookings(email: email);
    successOrFailure.fold(
      (failure) => logger.e(failure),
      (response) {
        meetings.value = response;
      },
    );
    isLoading.value = false;
  }

  // cancel Meeting
  Future<void> cancelMeeting({required String email, required int id}) async {
    isLoading.value = true;
    final successOrFailure = await _services.cancelBooking(
      email: email,
      id: id,
    );
    successOrFailure.fold((failure) => logger.e(failure), (response) {
      Helpers.toast('Meeting Cancelled');
      return logger.i(response);
    });
    isLoading.value = false;
  }
}
