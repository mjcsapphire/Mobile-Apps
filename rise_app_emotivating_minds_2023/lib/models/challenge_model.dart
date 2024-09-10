import 'dart:convert';

List<ChallengeModel> ChallengeModelFromJson(String str) =>
    List<ChallengeModel>.from(
        json.decode(str).map((x) => ChallengeModel.fromJson(x)));

String ChallengeModelToJson(List<ChallengeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChallengeModel{
  final String? id;
  final String? name;
  final String? introduction;
  final String? purpose;
  final String? goals;
  final String? activity;
  final String? challenge;
  final String? pathway;
  final String? pathway_name;
  final String? level;
  final String? image;
  final String? paid;
  final String? status;
  final String? assigned;
  final String? autoAssigned;
  final String? userPaid;

  ChallengeModel({
    required this.id,
    required this.name,
    required this.introduction,
    required this.purpose,
    required this.goals,
    required this.activity,
    required this.challenge,
    required this.pathway,
    required this.pathway_name,
    required this.level,
    required this.image,
    required this.paid,
    required this.assigned,
    required this.autoAssigned,
    required this.userPaid,
    required this.status
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) => ChallengeModel(
    id: json["id"],
    name: json["name"],
    introduction: json["introduction"],
    purpose: json["purpose"],
    goals: json["goals"],
    activity: json["activity"],
    challenge: json["challenge"],
    pathway: json["pathway"],
    pathway_name: json["pathway_name"],
    level: json["level"],
    image: json["image"],
    paid: json["paid"],
    status: json["status"],
    assigned: json["assigned"],
    autoAssigned: json["autoAssigned"],
    userPaid: json["userPaid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "introduction": introduction,
    "purpose": purpose,
    "goals": goals,
    "activity": activity,
    "challenge": challenge,
    "pathway": pathway,
    "pathway_name": pathway_name,
    "level": level,
    "image": image,
    "paid": paid,
    "status": status,
    "assigned": assigned,
    "autoAssigned": autoAssigned,
    "userPaid": userPaid,
  };

}