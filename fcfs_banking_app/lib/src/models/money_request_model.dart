class MoneyRequest {
  final String requesterId;
  final String receiverId;
  final String phoneNumber;
  final String name;
  final double amount;
  final String note;
  final String status;
  final DateTime date;

  MoneyRequest({
    required this.requesterId,
    required this.receiverId,
    required this.phoneNumber,
    required this.name,
    required this.amount,
    required this.note,
    required this.status,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'requesterId': requesterId,
      'receiverId': receiverId,
      'phoneNumber': phoneNumber,
      'name': name,
      'amount': amount,
      'note': note,
      'status': status,
      'date': date.toIso8601String(),
    };
  }

  factory MoneyRequest.fromMap(Map<String, dynamic> map) {
    return MoneyRequest(
      requesterId: map['requesterId'],
      receiverId: map['receiverId'],
      phoneNumber: map['phoneNumber'],
      name: map['name'],
      amount: map['amount'],
      note: map['note'],
      status: map['status'],
      date: DateTime.parse(map['date']),
    );
  }
}
