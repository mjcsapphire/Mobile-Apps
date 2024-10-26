import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfs_banking_app/src/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  // Observable user
  var user = Rx<UserModel?>(null);

  RxBool isLoading = false.obs;

  // Signup function
  Future<void> signUpUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String country,
    required String zipCode,
    required String phoneNumber,
    required File idImage,
  }) async {
    try {
      isLoading.value = true;
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      // Upload ID image to Firebase Storage
      String governmentIdUrl =
          await storeFileToFirebase("profilePic/$uid", idImage);

      // Create user model
      UserModel newUser = UserModel(
        uid: uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        country: country,
        zipCode: zipCode,
        phoneNumber: phoneNumber,
        governmentIdUrl: governmentIdUrl,
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(uid).set(newUser.toMap());

      // Update observable user
      user.value = newUser;

      // Optional: Update the Firebase Auth user profile
      await userCredential.user!.updateDisplayName("$firstName $lastName");
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Function to upload ID image to Firebase Storage
  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // Sign-in function
  Future<void> signInUser(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await fetchUserData(userCredential.user!.uid);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch user data from Firestore
  Future<void> fetchUserData(String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();
    if (userDoc.exists) {
      user.value = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    }
  }

  // Logout function
  Future<void> signOutUser() async {
    await _auth.signOut();
    user.value = null;
  }
}
