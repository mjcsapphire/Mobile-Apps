class DirectDebitRequest {
  final String id;
  final String personalUserId;
  final String businessUserId;
  final double amount;
  final String frequency;
  final String status;
  final DateTime startDate;
  final DateTime nextPaymentDate;

  DirectDebitRequest({
    required this.id,
    required this.personalUserId,
    required this.businessUserId,
    required this.amount,
    required this.frequency,
    required this.status,
    required this.startDate,
    required this.nextPaymentDate,
  });

  factory DirectDebitRequest.fromMap(Map<String, dynamic> data, String id) {
    return DirectDebitRequest(
      id: id,
      personalUserId: data['personalUserId'],
      businessUserId: data['businessUserId'],
      amount: data['amount'],
      frequency: data['frequency'],
      status: data['status'],
      startDate: DateTime.parse(data['startDate']),
      nextPaymentDate: DateTime.parse(data['nextPaymentDate']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'personalUserId': personalUserId,
      'businessUserId': businessUserId,
      'amount': amount,
      'frequency': frequency,
      'status': status,
      'startDate': startDate.toIso8601String(),
      'nextPaymentDate': nextPaymentDate.toIso8601String(),
    };
  }
}
