import 'package:rise_pathway/core/utils/environment.dart';

class Config {
  static String baseURL = Environment.apiBaseUrl;
  static String imageURL = Environment.apiImageUrl;

  // User endpoints
  static const String fetchUser = "/getUser";
  static const String addUser = "/addUser";
  static const String updateMood = "/updateMood";
  static const String updateUser = "/updateUser";
  static const String registerRise = "/registerRise";
  static const String updateUserRiseImage = "/updateUserRiseImage";
  static const String updateUserRiseSound = "/updateUserRiseSound";

  // Journal endpoints
  static const String fetchJournalEntries = "/getJournalEntries";
  static const String addJournalEntry = "/addJournalEntry";
  static const String updateJournalEntry = "/updateJournalEntry";
  static const String deleteJournalEntry = "/deleteJournalEntry";

  // Challenge endpoints
  static const String fetchChallenges = "/getChallenges";
  static const String fetchRelatedChallenges = "/getRelatedChallenges";
  static const String addChallenge = "/addChallenge";
  static const String removeChallenge = "/removeChallenge";
  static const String completeChallenge = "/completeChallenge";

  // Pathway endpoints
  static const String fetchPathways = "/getPathways";
  static const String fetchQuestions = "/getPathwayQuestions";
  static const String submitPathwayTest = "/submitPathwayTest";

  // Other endpoints
  static const String removeDancer = "/removeDancer";
  static const String uploadImage = "/uploadImage";
}
