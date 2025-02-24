import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/meeting_services.dart';
import 'package:rise_pathway/src/models/meeting/time_slot_model.dart';

class MeetingController extends GetxController {
  final Dio dio;

  MeetingController({required this.dio});

  late final _services = MeetingServices(dio: dio);

  final timeSlots = <TimeSlot>[].obs;
  final isLoading = false.obs;

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
}
