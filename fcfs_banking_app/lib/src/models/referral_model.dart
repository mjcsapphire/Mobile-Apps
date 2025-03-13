class ReferralModel {
  final String referralCode;
  final List<String> referredUserIds;
  final int bonusEarned;
  final String? referredBy;

  ReferralModel({
    required this.referralCode,
    required this.referredUserIds,
    required this.bonusEarned,
    this.referredBy,
  });

  factory ReferralModel.fromMap(Map<String, dynamic> data) {
    return ReferralModel(
      referralCode: data['referralCode'] ?? '',
      referredUserIds: List<String>.from(data['referredUserIds'] ?? []),
      bonusEarned: data['bonusEarned'] ?? 0,
      referredBy: data['referredBy'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'referralCode': referralCode,
      'referredUserIds': referredUserIds,
      'bonusEarned': bonusEarned,
      'referredBy': referredBy,
    };
  }

  ReferralModel copyWith({
    String? referralCode,
    List<String>? referredUserIds,
    int? bonusEarned,
    String? referredBy,
  }) {
    return ReferralModel(
      referralCode: referralCode ?? this.referralCode,
      referredUserIds: referredUserIds ?? this.referredUserIds,
      bonusEarned: bonusEarned ?? this.bonusEarned,
      referredBy: referredBy ?? this.referredBy,
    );
  }
}
