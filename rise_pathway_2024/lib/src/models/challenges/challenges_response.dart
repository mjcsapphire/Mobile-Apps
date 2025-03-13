import 'dart:convert';

class ChallengesResponse {
  String image;
  String name;
  String introduction;
  String purpose;
  String id;
  String goals;
  String activity;
  String challenge;
  String pathway;
  String pathwayName;
  String level;
  String paid;
  String assigned;
  String autoAssigned;
  String userPaid;
  String status;

  ChallengesResponse({
    required this.image,
    required this.name,
    required this.introduction,
    required this.purpose,
    required this.id,
    required this.goals,
    required this.activity,
    required this.challenge,
    required this.pathway,
    required this.pathwayName,
    required this.level,
    required this.paid,
    required this.assigned,
    required this.autoAssigned,
    required this.userPaid,
    required this.status,
  });

  ChallengesResponse copyWith({
    String? image,
    String? name,
    String? introduction,
    String? purpose,
    String? id,
    String? goals,
    String? activity,
    String? challenge,
    String? pathway,
    String? pathwayName,
    String? level,
    String? paid,
    String? assigned,
    String? autoAssigned,
    String? userPaid,
    String? status,
  }) =>
      ChallengesResponse(
        image: image ?? this.image,
        name: name ?? this.name,
        introduction: introduction ?? this.introduction,
        purpose: purpose ?? this.purpose,
        id: id ?? this.id,
        goals: goals ?? this.goals,
        activity: activity ?? this.activity,
        challenge: challenge ?? this.challenge,
        pathway: pathway ?? this.pathway,
        pathwayName: pathwayName ?? this.pathwayName,
        level: level ?? this.level,
        paid: paid ?? this.paid,
        assigned: assigned ?? this.assigned,
        autoAssigned: autoAssigned ?? this.autoAssigned,
        userPaid: userPaid ?? this.userPaid,
        status: status ?? this.status,
      );

  factory ChallengesResponse.fromRawJson(String str) =>
      ChallengesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChallengesResponse.fromJson(Map<String, dynamic> json) =>
      ChallengesResponse(
        image: json["image"],
        name: json["name"],
        introduction: json["introduction"],
        purpose: json["purpose"],
        id: json["id"],
        goals: json["goals"],
        activity: json["activity"],
        challenge: json["challenge"],
        pathway: json["pathway"],
        pathwayName: json["pathway_name"],
        level: json["level"],
        paid: json["paid"],
        assigned: json["assigned"],
        autoAssigned: json["autoAssigned"],
        userPaid: json["userPaid"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "introduction": introduction,
        "purpose": purpose,
        "id": id,
        "goals": goals,
        "activity": activity,
        "challenge": challenge,
        "pathway": pathway,
        "pathway_name": pathwayName,
        "level": level,
        "paid": paid,
        "assigned": assigned,
        "autoAssigned": autoAssigned,
        "userPaid": userPaid,
        "status": status,
      };
}
