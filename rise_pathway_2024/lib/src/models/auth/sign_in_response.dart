import 'dart:convert';

class SignInResponse {
  String? mobileAppProfilePic;
  String? firstname;
  String? surname;
  String? userEmail;
  String? paid;
  String? riseSound;
  String? riseImage;
  String? mood;
  String? risesDay;
  String? risesWeek;
  String? risesMonth;
  String? challengesDay;
  String? challengesWeek;
  String? challengesMonth;
  String? healthPathway;
  String? relationshipsPathway;
  String? adaptationPathway;
  String? personalPathway;
  String? wisdomPathway;
  String? copingPathway;
  String? engagementPathway;
  String? emotionsPathway;
  String? identityPathway;
  String? decisionPathway;

  SignInResponse({
    this.mobileAppProfilePic,
    this.firstname,
    this.surname,
    this.userEmail,
    this.paid,
    this.riseSound,
    this.riseImage,
    this.mood,
    this.risesDay,
    this.risesWeek,
    this.risesMonth,
    this.challengesDay,
    this.challengesWeek,
    this.challengesMonth,
    this.healthPathway,
    this.relationshipsPathway,
    this.adaptationPathway,
    this.personalPathway,
    this.wisdomPathway,
    this.copingPathway,
    this.engagementPathway,
    this.emotionsPathway,
    this.identityPathway,
    this.decisionPathway,
  });

  factory SignInResponse.fromRawJson(String str) =>
      SignInResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        mobileAppProfilePic: json["mobile_app_profile_pic"],
        firstname: json["firstname"],
        surname: json["surname"],
        userEmail: json["user_email"],
        paid: json["paid"],
        riseSound: json["riseSound"],
        riseImage: json["riseImage"],
        mood: json["mood"],
        risesDay: json["rises_day"],
        risesWeek: json["rises_week"],
        risesMonth: json["rises_month"],
        challengesDay: json["challenges_day"],
        challengesWeek: json["challenges_week"],
        challengesMonth: json["challenges_month"],
        healthPathway: json["health_pathway"],
        relationshipsPathway: json["relationships_pathway"],
        adaptationPathway: json["adaptation_pathway"],
        personalPathway: json["personal_pathway"],
        wisdomPathway: json["wisdom_pathway"],
        copingPathway: json["coping_pathway"],
        engagementPathway: json["engagement_pathway"],
        emotionsPathway: json["emotions_pathway"],
        identityPathway: json["identity_pathway"],
        decisionPathway: json["decision_pathway"],
      );

  Map<String, dynamic> toJson() => {
        "mobile_app_profile_pic": mobileAppProfilePic,
        "firstname": firstname,
        "surname": surname,
        "user_email": userEmail,
        "paid": paid,
        "riseSound": riseSound,
        "riseImage": riseImage,
        "mood": mood,
        "rises_day": risesDay,
        "rises_week": risesWeek,
        "rises_month": risesMonth,
        "challenges_day": challengesDay,
        "challenges_week": challengesWeek,
        "challenges_month": challengesMonth,
        "health_pathway": healthPathway,
        "relationships_pathway": relationshipsPathway,
        "adaptation_pathway": adaptationPathway,
        "personal_pathway": personalPathway,
        "wisdom_pathway": wisdomPathway,
        "coping_pathway": copingPathway,
        "engagement_pathway": engagementPathway,
        "emotions_pathway": emotionsPathway,
        "identity_pathway": identityPathway,
        "decision_pathway": decisionPathway,
      };
}
