import 'package:http/http.dart' as http;
import 'package:rise_app_emotivating_minds_2023/models/journal_model.dart';
import '../models/challenge_model.dart';
import '../models/pathway_model.dart';
import '../models/questions_model.dart';
import '../models/user_model.dart';
import 'network_utils.dart';

Future addDancer(String email) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/addUser?email=$email', ''));
}
Future updateMood(String email, String mood) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/updateMood?email=$email&mood=$mood', ''));
}
Future removeDancer(String email, String BasicNo) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/removeDancer?email=$email&BasicNo=$BasicNo', ''));
}
Future uploadImageAPI(String email, String filename) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/uploadImage?user_email=$email&filename=$filename', ''));
}
Future updateUser(String email, String firstname, String surname) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/updateUser?email=$email&firstname=$firstname&surname=$surname', ''));
}
Future updateUserRiseImage(String email, String image) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/updateUserRiseImage?email=$email&image=$image', ''));
}
Future updateUserRiseSound(String email, String sound) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/updateUserRiseSound?email=$email&sound=$sound', ''));
}
Future registerRise(String email) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/registerRise?email=$email', ''));
}
Future completeChallenge(String email, String id) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/completeChallenge?email=$email&challenge=$id', ''));
}
Future addChallenge(String email, String id) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/addChallenge?email=$email&challenge=$id', ''));
}
Future removeChallenge(String email, String id) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/removeChallenge?email=$email&challenge=$id', ''));
}
Future addJournalEntry(String email, String title, String entry) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/addJournalEntry?email=$email&title=$title&entry=$entry', ''));
}
Future updateJournalEntry(String id, String title, String entry) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/updateJournalEntry?id=$id&title=$title&entry=$entry', ''));
}
Future deleteJournalEntry(String id) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/deleteJournalEntry?id=$id', ''));
}
Future submitPathwayTest(String email, String pathway, int question1, int question2, int question3,
    int question4, int question5, int question6, int question7, int question8,
    int question9, int question10) async {
  return handleResponse(await postRequest('https://www.risepathway.com/api/connections/submitPathwayTest?email=$email&pathway=$pathway'
      '&question1=$question1&question2=$question2&question3=$question3&question4=$question4&question5=$question5&question6=$question6'
      '&question7=$question7&question8=$question8&question9=$question9&question10=$question10', ''));
}

class HttpService {

  static Future<List<UserModel>?> fetchUser(email) async {
    var response = await http.get(Uri.parse("https://www.risepathway.com/api/connections/getUser?email=$email"));
    if (response.statusCode == 200) {
      var data = response.body;
      if(data == '{"message":"No user found"}'){
        return null;
      }
      return UserModelFromJson(data);
    } else {
      throw Exception();
    }
  }

  static Future<List<JournalModel>?> fetchJournalEntries(email) async {
    var response = await http.get(Uri.parse("https://www.risepathway.com/api/connections/getJournalEntries?email=$email"));
    if (response.statusCode == 200) {
      var data = response.body;
      if(data == '{"message":"No entries found"}'){
        return null;
      }
      return JournalModelFromJson(data);
    } else {
      throw Exception();
    }
  }

  static Future<List<ChallengeModel>?> fetchChallenges(email) async {
    var response = await http.get(Uri.parse("https://www.risepathway.com/api/connections/getChallenges?email=$email"));
    if (response.statusCode == 200) {
      var data = response.body;
      if(data == '{"message":"No challenges found"}'){
        return null;
      }
      return ChallengeModelFromJson(data);
    } else {
      throw Exception();
    }
  }

  static Future<List<ChallengeModel>?> fetchRelatedChallenges(email, id, pathway) async {
    var response = await http.get(Uri.parse("https://www.risepathway.com/api/connections/getRelatedChallenges?email=$email&id=$id&pathway=$pathway&paid=0"));
    if (response.statusCode == 200) {
      var data = response.body;
      if(data == '{"message":"No challenges found"}'){
        return null;
      }
      return ChallengeModelFromJson(data);
    } else {
      throw Exception();
    }
  }
  static Future<List<ChallengeModel>?> fetchRelatedPremiumChallenges(email, id, pathway) async {
    var response = await http.get(Uri.parse("https://www.risepathway.com/api/connections/getRelatedChallenges?email=$email&id=$id&pathway=$pathway&paid=1"));
    if (response.statusCode == 200) {
      var data = response.body;
      if(data == '{"message":"No challenges found"}'){
        return null;
      }
      return ChallengeModelFromJson(data);
    } else {
      throw Exception();
    }
  }
  static Future<List<PathwayModel>?> fetchPathways(email) async {
    var response = await http.get(Uri.parse("https://www.risepathway.com/api/connections/getPathways?email=$email"));
    if (response.statusCode == 200) {
      var data = response.body;
      if(data == '{"message":"No pathways found"}'){
        return null;
      }
      return PathwayModelFromJson(data);
    } else {
      throw Exception();
    }
  }
  static Future<List<QuestionsModel>?> fetchQuestions(pathway) async {
    var response = await http.get(Uri.parse("https://www.risepathway.com/api/connections/getPathwayQuestions?pathway=$pathway"));
    if (response.statusCode == 200) {
      var data = response.body;
      if(data == '{"message":"No questions found"}'){
        return null;
      }
      return QuestionsModelFromJson(data);
    } else {
      throw Exception();
    }
  }





}