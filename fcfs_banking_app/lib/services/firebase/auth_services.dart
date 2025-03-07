import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fcfs_banking_app/src/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // Sign up user
  Future<Either<String, UserModel>> signUpUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String country,
    required String zipCode,
    required String phoneNumber,
    required String role,
    required File idImage,
    required String businessName,
  }) async {
    try {
      // Create user in Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      // Upload ID image to Firebase Storage
      String governmentIdUrl =
          await storeFileToFirebase("govtVerifiedID/$uid", idImage);

      // Create user model
      UserModel newUser = UserModel(
        uid: uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        country: country,
        zipCode: zipCode,
        phoneNumber: phoneNumber,
        role: role,
        governmentIdUrl: governmentIdUrl,
        balance: 0.0,
        businessName: businessName,
        fcmToken: '',
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(uid).set(newUser.toMap());

      return Right(newUser);
    } on FirebaseAuthException catch (e) {
      // Check for specific Firebase error codes to return meaningful messages
      if (e.code == 'email-already-in-use') {
        return const Left("This email is already associated with an account.");
      } else if (e.code == 'invalid-email') {
        return const Left("The email address is not valid.");
      } else if (e.code == 'weak-password') {
        return const Left(
            "The password is too weak. Please choose a stronger password.");
      }
      return Left("Error signing up: ${e.message}");
    } catch (e) {
      return Left("Error signing up user: $e");
    }
  }

  // Sign in user
  Future<Either<String, UserModel>> signInUser(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await fetchUserData(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      // Check for specific error codes and return custom messages
      if (e.code == 'user-not-found') {
        return const Left("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        return const Left("Incorrect password. Please try again.");
      }
      return Left("Error signing in: ${e.message}");
    } catch (e) {
      return Left("Unexpected error: $e");
    }
  }

  // Fetch user data by UID
  Future<Either<String, UserModel>> fetchUserData(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return Right(UserModel.fromMap(userDoc.data() as Map<String, dynamic>));
      } else {
        return const Left("User not found");
      }
    } catch (e) {
      return Left("Error fetching user data: $e");
    }
  }

  // Upload file to Firebase Storage
  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    return await snap.ref.getDownloadURL();
  }

  // Sign out user
  Future<Either<String, void>> signOutUser() async {
    try {
      await _auth.signOut();
      return const Right(null);
    } catch (e) {
      return Left("Error signing out: $e");
    }
  }
}
