class UserModel {
  String uid;
  String firstName;
  String lastName;
  String email;
  String country;
  String zipCode;
  String phoneNumber;
  String role;
  String? profileImageUrl;
  String governmentIdUrl;
  double balance;
  String businessName;
  String fcmToken;
  double dailyLimit;
  double monthlyLimit;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.country,
    required this.zipCode,
    required this.phoneNumber,
    required this.role,
    this.profileImageUrl,
    required this.governmentIdUrl,
    required this.balance,
    required this.businessName,
    required this.fcmToken,
    this.dailyLimit = 5000.0,
    this.monthlyLimit = 8000.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'country': country,
      'zipCode': zipCode,
      'phoneNumber': phoneNumber,
      'role': role,
      'profileImageUrl': profileImageUrl,
      'governmentIdUrl': governmentIdUrl,
      'balance': balance,
      'businessName': businessName,
      'fcmToken': fcmToken,
      'dailyLimit': dailyLimit,
      'monthlyLimit': monthlyLimit,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      country: map['country'],
      zipCode: map['zipCode'],
      phoneNumber: map['phoneNumber'],
      role: map['role'],
      profileImageUrl: map['profileImageUrl'],
      governmentIdUrl: map['governmentIdUrl'],
      balance: double.tryParse(map['balance'].toString()) ?? 0.0,
      businessName: map['businessName'],
      fcmToken: map['fcmToken'],
      dailyLimit: double.tryParse(map['dailyLimit'].toString()) ?? 0.0,
      monthlyLimit: double.tryParse(map['monthlyLimit'].toString()) ?? 0.0,
    );
  }
}
