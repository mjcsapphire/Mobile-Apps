import 'dart:io';

import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/firebase/idea_submission_service.dart';
import 'package:fcfs_banking_app/services/router/router.dart';
import 'package:fcfs_banking_app/services/router/routes_path.dart';
import 'package:fcfs_banking_app/src/models/community_funding_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class IdeaSubmissionController extends GetxController {
  final IdeaSubmissionService _service = IdeaSubmissionService();
  RxBool isLoading = false.obs;
  var ideas = <IdeaSubmissionModel>[].obs;
  var logger = Logger();

  Future<void> submitIdea(IdeaSubmissionModel idea, File thumbnail) async {
    isLoading.value = true;
    try {
      await _service.submitIdea(idea, thumbnail);
      fetchIdeas();
      router.pop();
    } catch (e) {
      AppHelpers.toast('Error submitting idea: $e');
      logger.e('Error submitting idea: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // update idea submission
  Future<void> updateIdea(IdeaSubmissionModel idea, File thumbnail) async {
    isLoading.value = true;
    try {
      await _service.updateIdea(idea, thumbnail);
      fetchIdeas();
      router.push(RoutesPath.communityFunding);
    } catch (e) {
      AppHelpers.toast('Error updating idea: $e');
      logger.e('Error updating idea: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchIdeas() async {
    isLoading.value = true;
    try {
      ideas.value = await _service.fetchIdeas();
    } catch (e) {
      AppHelpers.toast('Error fetching ideas: $e');
      logger.e('Error fetching ideas: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update the raised money of an idea
  Future<void> updateRaisedMoney(String ideaId, double newAmount) async {
    isLoading.value = true;
    try {
      // Update the raised money in the service/database
      await _service.updateRaisedMoney(ideaId, newAmount);

      // Find the idea locally and update it
      int index = ideas.indexWhere((idea) => idea.id == ideaId);
      if (index != -1) {
        ideas[index] = ideas[index].copyWith(raisedAmount: newAmount);
      }
      // Optionally fetch ideas again if you prefer syncing from the backend
    } catch (e) {
      AppHelpers.toast('Error updating raised money: $e');
      logger.e('Error updating raised money: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // update number of inversters
  Future<void> updateInvesters(String ideaId, int investors) async {
    isLoading.value = true;
    try {
      // Update the raised money in the service/database
      await _service.updateInvestors(ideaId, investors);

      // Find the idea locally and update it
      int index = ideas.indexWhere((idea) => idea.id == ideaId);
      if (index != -1) {
        ideas[index] = ideas[index].copyWith(totalInvestors: investors);
      }
      // Optionally fetch ideas again if you prefer syncing from the backend
      fetchIdeas();
    } catch (e) {
      AppHelpers.toast('Error updating raised money: $e');
      logger.e('Error updating raised money: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
