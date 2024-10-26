class UserModel {
  String uid;
  String firstName;
  String lastName;
  String email;
  String country;
  String zipCode;
  String phoneNumber;
  String governmentIdUrl;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.country,
    required this.zipCode,
    required this.phoneNumber,
    required this.governmentIdUrl,
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
      'governmentIdUrl': governmentIdUrl,
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
      governmentIdUrl: map['governmentIdUrl'],
    );
  }
}
