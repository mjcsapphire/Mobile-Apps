import 'dart:convert';

class GetMeetingResponse {
  String id;
  DateTime dateBooked;
  String timeBooked;
  String coach;
  Null meetingLink;

  GetMeetingResponse({
    required this.id,
    required this.dateBooked,
    required this.timeBooked,
    required this.coach,
    this.meetingLink,
  });

  factory GetMeetingResponse.fromJson(Map<String, dynamic> json) {
    return GetMeetingResponse(
      id: json['id'],
      dateBooked: DateTime.parse(json['date_booked']),
      timeBooked: json['time_booked'],
      coach: json['coach'],
      meetingLink: json['meeting_link'],
    );
  }

  factory GetMeetingResponse.fromRawJson(String str) =>
      GetMeetingResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date_booked': dateBooked.toIso8601String(),
      'time_booked': timeBooked,
      'coach': coach,
      'meeting_link': meetingLink,
    };
  }

  GetMeetingResponse copyWith({
    String? id,
    DateTime? dateBooked,
    String? timeBooked,
    String? coach,
    Null meetingLink,
  }) {
    return GetMeetingResponse(
      id: id ?? this.id,
      dateBooked: dateBooked ?? this.dateBooked,
      timeBooked: timeBooked ?? this.timeBooked,
      coach: coach ?? this.coach,
      meetingLink: meetingLink ?? this.meetingLink,
    );
  }
}
