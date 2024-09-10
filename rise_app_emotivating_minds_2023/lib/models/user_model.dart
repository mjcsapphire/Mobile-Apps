import 'dart:convert';

List<UserModel> UserModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String UserModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    this.firstname,
    this.surname,
    this.user_email,
    this.paid,
    this.mobile_app_profile_pic,
    this.mood,
    this.riseImage,
    this.riseSound,
    this.rises_day,
    this.rises_week,
    this.rises_month,
    this.challenges_day,
    this.challenges_week,
    this.challenges_month,
    this.health_pathway,
    this.relationships_pathway,
    this.adaptation_pathway,
    this.personal_pathway,
    this.wisdom_pathway,
    this.coping_pathway,
    this.engagement_pathway,
    this.emotions_pathway,
    this.identity_pathway,
    this.decision_pathway,
  });

  final String? firstname;
  final String? surname;
  final String? user_email;
  final String? paid;
  final String? mobile_app_profile_pic;
  final String? mood;
  final String? riseImage;
  final String? riseSound;
  final String? rises_day;
  final String? rises_week;
  final String? rises_month;
  final String? challenges_day;
  final String? challenges_week;
  final String? challenges_month;
  final String? health_pathway;
  final String? relationships_pathway;
  final String? adaptation_pathway;
  final String? personal_pathway;
  final String? wisdom_pathway;
  final String? coping_pathway;
  final String? engagement_pathway;
  final String? emotions_pathway;
  final String? identity_pathway;
  final String? decision_pathway;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstname: json["firstname"],
        surname: json["surname"],
        user_email: json["user_email"],
        paid: json["paid"],
        mood: json["mood"],
        riseImage: json["riseImage"],
        riseSound: json["riseSound"],
        mobile_app_profile_pic: json["mobile_app_profile_pic"],
        rises_day: json["rises_day"],
        rises_week: json["rises_week"],
        rises_month: json["rises_month"],
        challenges_day: json["challenges_day"],
        challenges_week: json["challenges_week"],
        challenges_month: json["challenges_month"],
        health_pathway: json["health_pathway"],
        relationships_pathway: json["relationships_pathway"],
        adaptation_pathway: json["adaptation_pathway"],
        personal_pathway: json["personal_pathway"],
        wisdom_pathway: json["wisdom_pathway"],
        coping_pathway: json["coping_pathway"],
        engagement_pathway: json["engagement_pathway"],
        emotions_pathway: json["emotions_pathway"],
        identity_pathway: json["identity_pathway"],
        decision_pathway: json["decision_pathway"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "surname": surname,
        "user_email": user_email,
        "paid": paid,
        "mood": mood,
        "riseImage": riseImage,
        "riseSound": riseSound,
        "mobile_app_profile_pic": mobile_app_profile_pic,
        "rises_day": rises_day,
        "rises_week": rises_week,
        "rises_month": rises_month,
        "challenges_day": challenges_day,
        "challenges_week": challenges_week,
        "challenges_month": challenges_month,
        "health_pathway": health_pathway,
        "relationships_pathway": relationships_pathway,
        "adaptation_pathway": adaptation_pathway,
        "personal_pathway": personal_pathway,
        "wisdom_pathway": wisdom_pathway,
        "coping_pathway": coping_pathway,
        "engagement_pathway": engagement_pathway,
        "emotions_pathway": emotions_pathway,
        "identity_pathway": identity_pathway,
        "decision_pathway": decision_pathway,
      };
}
