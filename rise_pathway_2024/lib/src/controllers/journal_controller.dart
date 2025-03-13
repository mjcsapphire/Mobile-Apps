import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/journal_services.dart';
import 'package:rise_pathway/src/models/journals/journal_response.dart';

class JournalController extends GetxController {
  JournalController({
    required this.dio,
  });

  final Dio dio;
  late final _services = JournalServices(dio: dio);

  final journals = <JournalEntriesResponse>[].obs;
  final isLoading = false.obs;

  Future<void> addJournal({
    required String email,
    required String title,
    required String content,
  }) async {
    isLoading.value = true;
    final successOrFailure = await _services.addJournal(
      email: email,
      title: title,
      content: content,
    );
    successOrFailure.fold(
      (failure) {
        logger.e("Error In Add Journal: $failure");
      },
      (success) async {
        logger.d("Successfully Add Journal: $success");
        await fetchJournals(email: email);
      },
    );
    isLoading.value = false;
  }

  Future<void> fetchJournals({
    required String email,
  }) async {
    isLoading.value = true;
    final successOrFailure = await _services.fetchJournals(
      email: email,
    );
    successOrFailure.fold(
      (failure) => logger.e(failure),
      (response) {
        journals.clear();
        journals.addAll(response);
      },
    );
    isLoading.value = false;
  }

  Future<void> updateJournal({
    required String email,
    required String id,
    required String title,
    required String content,
  }) async {
    isLoading.value = true;
    final successOrFailure = await _services.updateJournal(
      email: email,
      id: id,
      title: title,
      content: content,
    );
    successOrFailure.fold(
      (failure) {
        logger.e("Error In updating Journal: $failure");
      },
      (success) async {
        logger.d("Successfully updated Journal: $success");
        await fetchJournals(email: email);
      },
    );
    isLoading.value = false;
  }

  Future<void> deleteJournal({
    required String email,
    required String id,
  }) async {
    isLoading.value = true;
    final successOrFailure = await _services.deleteJournal(
      email: email,
      id: id,
    );
    successOrFailure.fold(
      (failure) {
        logger.e("Error In Delete Journal: $failure");
      },
      (success) async {
        logger.d("Successfully Delete Journal: $success");
        await fetchJournals(email: email);
      },
    );
    isLoading.value = false;
  }
}
