import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).add(data);
      debugPrint('Document added successfully!');
    } catch (e) {
      debugPrint('Error adding document: $e');
      rethrow;
    }
  }

  Future<String> addPost(String collection, Map<String, dynamic> data) async {
    try {
      DocumentReference docRef =
          await _firestore.collection(collection).add(data);
      debugPrint('Document added successfully!');
      return docRef.id;
    } catch (e) {
      debugPrint('Error adding document: $e');
      rethrow;
    }
  }

  Future<void> setDocument(
      String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(docId).set(data);
      debugPrint('Document set successfully!');
    } catch (e) {
      debugPrint('Error setting document: $e');
      rethrow;
    }
  }

  Future<void> updateDocument(
      String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(docId).update(data);
      debugPrint('Document updated successfully!');
    } catch (e) {
      debugPrint('Error updating document: $e');
      rethrow;
    }
  }

  Future<void> deleteDocument(String collection, String docId) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
      debugPrint('Document deleted successfully!');
    } catch (e) {
      debugPrint('Error deleting document: $e');
      rethrow;
    }
  }

  Future<DocumentSnapshot> getDocument(String collection, String docId) async {
    try {
      DocumentSnapshot document =
          await _firestore.collection(collection).doc(docId).get();
      return document;
    } catch (e) {
      debugPrint('Error fetching document: $e');
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot>> getAllDocuments(String collection) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(collection).get();
      return querySnapshot.docs;
    } catch (e) {
      debugPrint('Error fetching documents: $e');
      rethrow;
    }
  }

  Future<List<PostComments?>?> getAllDocumentsByKeyValue(
      String collection, String key, String value) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(collection)
          .where(key, isEqualTo: value)
          .get();
      print("CHECKING KEY: " + key + " VALUE: " + value);
      print(querySnapshot.docs);
      return querySnapshot.docs.map((doc) {
        return PostComments.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      debugPrint('Error fetching documents: $e');
      rethrow;
    }
  }
}
