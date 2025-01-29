class IdeaSubmissionModel {
  final String id;
  final String businessOwner;
  final String userId;
  final String headline;
  final String description;
  final String highlights;
  final String purpose;
  final double targetAmount;
  final double raisedAmount;
  final double minimumInvestment;
  final double equityOffered;
  final String investorRole;
  final String stage;
  final String thumbnailUrl;
  final DateTime createdAt;
  final DateTime targetdDate;
  final double maximumInvestment;
  final int totalInvestors;

  IdeaSubmissionModel({
    required this.id,
    required this.businessOwner,
    required this.userId,
    required this.headline,
    required this.description,
    required this.highlights,
    required this.purpose,
    required this.targetAmount,
    required this.raisedAmount,
    required this.minimumInvestment,
    required this.equityOffered,
    required this.investorRole,
    required this.stage,
    required this.thumbnailUrl,
    required this.createdAt,
    required this.targetdDate,
    required this.maximumInvestment,
    required this.totalInvestors,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'businessOwner': businessOwner,
      'userId': userId,
      'headline': headline,
      'description': description,
      'highlights': highlights,
      'purpose': purpose,
      'targetAmount': targetAmount,
      'raisedAmount': raisedAmount,
      'minimumInvestment': minimumInvestment,
      'equityOffered': equityOffered,
      'investorRole': investorRole,
      'stage': stage,
      'thumbnailUrl': thumbnailUrl,
      'createdAt': createdAt,
      'targetdDate': targetdDate,
      'maximumInvestment': maximumInvestment,
      'totalInvestors': totalInvestors,
    };
  }

  factory IdeaSubmissionModel.fromMap(Map<String, dynamic> map) {
    return IdeaSubmissionModel(
      id: map['id'],
      businessOwner: map['businessOwner'],
      userId: map['userId'],
      headline: map['headline'],
      description: map['description'],
      highlights: map['highlights'],
      purpose: map['purpose'],
      targetAmount: map['targetAmount'],
      raisedAmount: map['raisedAmount'].toDouble(),
      minimumInvestment: map['minimumInvestment'],
      equityOffered: map['equityOffered'],
      investorRole: map['investorRole'],
      stage: map['stage'],
      thumbnailUrl: map['thumbnailUrl'],
      createdAt: map['createdAt'].toDate(),
      targetdDate: map['targetdDate'].toDate(),
      maximumInvestment: map['maximumInvestment'],
      totalInvestors: map['totalInvestors'],
    );
  }

  IdeaSubmissionModel copyWith({
    String? id,
    String? businessOwner,
    String? userId,
    String? headline,
    String? description,
    String? highlights,
    String? purpose,
    double? targetAmount,
    double? raisedAmount,
    double? minimumInvestment,
    double? equityOffered,
    String? investorRole,
    String? stage,
    String? thumbnailUrl,
    DateTime? createdAt,
    DateTime? targetdDate,
    double? maximumInvestment,
    int? totalInvestors,
  }) {
    return IdeaSubmissionModel(
      id: id ?? this.id,
      businessOwner: businessOwner ?? this.businessOwner,
      userId: userId ?? this.userId,
      headline: headline ?? this.headline,
      description: description ?? this.description,
      highlights: highlights ?? this.highlights,
      purpose: purpose ?? this.purpose,
      targetAmount: targetAmount ?? this.targetAmount,
      raisedAmount: raisedAmount ?? this.raisedAmount,
      minimumInvestment: minimumInvestment ?? this.minimumInvestment,
      equityOffered: equityOffered ?? this.equityOffered,
      investorRole: investorRole ?? this.investorRole,
      stage: stage ?? this.stage,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      createdAt: createdAt ?? this.createdAt,
      targetdDate: targetdDate ?? this.targetdDate,
      maximumInvestment: maximumInvestment ?? this.maximumInvestment,
      totalInvestors: totalInvestors ?? this.totalInvestors,
    );
  }
}
