import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final String? id;
  final String? userId;
  final double amount;
  final String? description;
  final DateTime date;
  final String? type; // "debit" or "credit"
  final String? status; // "pending", "completed", "failed"
  final Map<String, dynamic>? recipient;
  final double? fees;

  const TransactionModel({
    this.id,
    this.userId,
    required this.amount,
    this.description,
    required this.date,
    this.type,
    this.status,
    this.recipient,
    this.fees,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        amount,
        description,
        date,
        type,
        status,
        recipient,
        fees,
      ];

  // Convert to Firestore data
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
      'type': type,
      'status': status,
      'recipient': recipient,
      'fees': fees,
    };
  }

  // Factory constructor for creating a Transaction from Firestore data
  factory TransactionModel.fromMap(Map<String, dynamic> map, String docId) {
    return TransactionModel(
      id: docId,
      userId: map['userId'],
      amount: (map['amount'] as num).toDouble(),
      description: map['description'],
      date: DateTime.parse(map['date']),
      type: map['type'],
      status: map['status'],
      recipient: Map<String, dynamic>.from(map['recipient'] ?? {}),
      fees: (map['fees'] as num).toDouble(),
    );
  }

  // copyWith method for updating fields
  TransactionModel copyWith({
    String? id,
    String? userId,
    double? amount,
    String? description,
    DateTime? date,
    String? type,
    String? status,
    Map<String, dynamic>? recipient,
    double? fees,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
      type: type ?? this.type,
      status: status ?? this.status,
      recipient: recipient ?? this.recipient,
      fees: fees ?? this.fees,
    );
  }
}
