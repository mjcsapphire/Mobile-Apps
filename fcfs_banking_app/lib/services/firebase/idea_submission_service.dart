// lib/services/idea_submission_service.dart

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfs_banking_app/src/models/community_funding_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

class IdeaSubmissionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> submitIdea(IdeaSubmissionModel idea, File thumbnail) async {
    try {
      // Upload thumbnail to Firebase Storage
      final storageRef = _storage
          .ref()
          .child('thumbnails/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = storageRef.putFile(thumbnail);
      final snapshot = await uploadTask.whenComplete(() => {});
      final thumbnailUrl = await snapshot.ref.getDownloadURL();

      // Add idea submission to Firestore and retrieve the document ID
      final docRef = await _firestore
          .collection('ideaSubmissions')
          .add(idea.toMap()..['thumbnailUrl'] = thumbnailUrl);

      // Update the document with its ID
      await docRef.update({'id': docRef.id});
    } catch (e) {
      Logger().e('Error submitting idea: $e');
      throw Exception('Error submitting idea: $e');
    }
  }

  Future<List<IdeaSubmissionModel>> fetchIdeas() async {
    try {
      final querySnapshot = await _firestore
          .collection('ideaSubmissions')
          .orderBy('createdAt', descending: true)
          .get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return IdeaSubmissionModel.fromMap({
          ...data,
          'id': doc.id,
        });
      }).toList();
    } catch (e) {
      Logger().e('Error fetching ideas: $e');
      throw Exception('Error fetching ideas: $e');
    }
  }

  // update idea submission
  Future<void> updateIdea(IdeaSubmissionModel idea, File? thumbnail) async {
    try {
      String? thumbnailUrl;

      // Upload new thumbnail if provided
      if (thumbnail != null) {
        final storageRef = _storage
            .ref()
            .child('thumbnails/${DateTime.now().millisecondsSinceEpoch}');
        final uploadTask = storageRef.putFile(thumbnail);
        final snapshot = await uploadTask.whenComplete(() => {});
        thumbnailUrl = await snapshot.ref.getDownloadURL();
      }

      // Update idea submission in Firestore
      final updatedData = idea.toMap();
      if (thumbnailUrl != null) {
        updatedData['thumbnailUrl'] = thumbnailUrl;
      }

      await _firestore
          .collection('ideaSubmissions')
          .doc(idea.id)
          .update(updatedData);
    } catch (e) {
      Logger().e('Error updating idea: $e');
      throw Exception('Error updating idea: $e');
    }
  }

  Future<void> updateRaisedMoney(String ideaId, double newAmount) async {
    try {
      // Assuming you're using Firebase
      final docRef =
          FirebaseFirestore.instance.collection('ideaSubmissions').doc(ideaId);
      final doc = await docRef.get();
      final previousAmount = doc.get('raisedAmount');
      final totalAmount = previousAmount + newAmount;
      await docRef.update({'raisedAmount': totalAmount});
    } catch (e) {
      throw Exception('Failed to update raised money: $e');
    }
  }

    // update number of inverstors

 Future<void> updateInvestors(String ideaId, int newInvestors) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('ideaSubmissions').doc(ideaId);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);

        if (!snapshot.exists) {
          throw Exception('Document does not exist');
        }

        final previousInvestors = snapshot.get('totalInvestors') as int;
        final updatedInvestors = previousInvestors + newInvestors;

        transaction.update(docRef, {'totalInvestors': updatedInvestors});
      });
    } catch (e) {
      throw Exception('Failed to update investors: $e');
    }
  }


}

