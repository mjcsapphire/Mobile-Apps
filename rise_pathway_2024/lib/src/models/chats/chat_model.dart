import 'dart:convert';

class ChatResponse {
  String? id;
  String? message;
  String? sender;
  String? recipient;
  DateTime? dateSent;

  ChatResponse({
    this.id,
    this.message,
    this.sender,
    this.recipient,
    this.dateSent,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      id: json['id'],
      message: json['message'],
      sender: json['sender'],
      recipient: json['recipient'],
      dateSent: _parseDate(json['date_sent']),
    );
  }

  static DateTime? _parseDate(String? dateString) {
    if (dateString == null) return null;
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return _parseCustomDate(dateString);
    }
  }

  static DateTime? _parseCustomDate(String dateString) {
    final months = {
      "January": 1,
      "February": 2,
      "March": 3,
      "April": 4,
      "May": 5,
      "June": 6,
      "July": 7,
      "August": 8,
      "September": 9,
      "October": 10,
      "November": 11,
      "December": 12
    };

    final parts = dateString.split(" ");
    if (parts.length == 3) {
      final day = int.tryParse(parts[0]);
      final month = months[parts[1]];
      final year = int.tryParse(parts[2]);

      if (day != null && month != null && year != null) {
        return DateTime(year, month, day);
      }
    }
    return null;
  }

  factory ChatResponse.fromRawJson(String str) =>
      ChatResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'sender': sender,
        'recipient': recipient,
        'date_sent': dateSent != null
            ? "${dateSent!.day} ${_monthName(dateSent!.month)} ${dateSent!.year}"
            : null,
      };

  static String _monthName(int month) {
    const months = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month];
  }

  ChatResponse copyWith({
    String? id,
    String? message,
    String? sender,
    String? recipient,
    DateTime? dateSent,
  }) {
    return ChatResponse(
      id: id ?? this.id,
      message: message ?? this.message,
      sender: sender ?? this.sender,
      recipient: recipient ?? this.recipient,
      dateSent: dateSent ?? this.dateSent,
    );
  }
}
