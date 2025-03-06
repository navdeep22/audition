import 'package:audition/core/data/app_singleton/user_singleton.dart';
import 'package:audition/core/network/repository/api_services/api_service_record.dart';
import 'package:audition/core/network/repository/firebase_services/firebase_services.dart';
import 'package:audition/core/network/server_keys/firebase_collections.dart';
import 'package:audition/features/record/model/all_music_response_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordServices {
  ApiServiceRecord apiService = ApiServiceRecord();
  FirestoreService firestoreService = FirestoreService();

  Future<List<MusicModel>?> getAllUploadedMusic(BuildContext context) async {
    try {
      return apiService.getAllUploadedMusic(context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch uploaded music: $error');
    }
  }

  Future<bool?> addMusicAsFav(String musicId, BuildContext context) async {
    try {
      return await apiService.addMusicAsFav(musicId, context);
    } on Exception catch (error) {
      throw Exception('Failed to add music in fav list $error');
    }
  }

  Future<List<MusicModel>?> getAllSavedMusic(BuildContext context) async {
    try {
      return apiService.getAllSavedMusic(context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch uploaded music: $error');
    }
  }

  static Future<void> getLocationResults(String input,
      Function(List<dynamic>) updatePlaceList, BuildContext context) async {
    return await ApiServiceRecord.getLocationResults(
        input, updatePlaceList, context);
  }

  Future<bool?> uploadVideoToServer(
      MusicModel musicModel,
      String location,
      String caption,
      String hashtag,
      String postId,
      String contestId,
      String videoLink,
      bool isAllowComment,
      bool isAllowDuet,
      bool isAllowSharing,
      BuildContext context) async {
    if (contestId.isEmpty) {
      return await apiService.uploadVideoToServer(
          musicModel,
          location,
          caption,
          hashtag,
          postId,
          contestId,
          videoLink,
          isAllowComment,
          isAllowDuet,
          isAllowSharing,
          context);
    } else {
      return await apiService.uploadVideoToContest(
          musicModel,
          location,
          caption,
          hashtag,
          postId,
          contestId,
          videoLink,
          isAllowComment,
          isAllowDuet,
          isAllowSharing,
          context);
    }
  }

  Future<String?> uploadVideoToFirebase(
      String videoUrl, String videoCaption, String hashtag) async {
    Map<String, dynamic> data = {
      FirebaseDocumentKeys.videoUrl: videoUrl,
      FirebaseDocumentKeys.videoCaption: videoCaption,
      FirebaseDocumentKeys.hashTag: hashtag,
      FirebaseDocumentKeys.lat: "",
      FirebaseDocumentKeys.long: "",
      FirebaseDocumentKeys.userName: UserSingleton().userData?.name ?? "",
      FirebaseDocumentKeys.postId: "",
      FirebaseDocumentKeys.likCount: 0,
      FirebaseDocumentKeys.dateCreated:
          DateFormat("d MMMM yyyy h:mm a").format(DateTime.now()),
      FirebaseDocumentKeys.userId: UserSingleton().userData?.id ?? "",
      FirebaseDocumentKeys.language: "hindi",
    };

    try {
      return await firestoreService.addPost(
          FirebaseCollections.firebasePostCollection, data);
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }
}
