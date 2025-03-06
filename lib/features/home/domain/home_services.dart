import 'package:audition/core/data/app_singleton/user_singleton.dart';
import 'package:audition/core/data/app_toast.dart';
import 'package:audition/core/network/repository/api_services/api_services_home.dart';
import 'package:audition/core/network/repository/firebase_services/firebase_services.dart';
import 'package:audition/core/network/server_keys/firebase_collections.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/home/model/get_live_contest_response_model.dart';
import 'package:audition/features/home/model/report_response_model.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:uuid/uuid.dart';

class HomeServices {
  ApiServiceHome apiService = ApiServiceHome();
  FirestoreService firestoreService = FirestoreService();

  Future<List<VideoResponse>?> fetchVideos(
      String language, BuildContext context) async {
    print("API CALLED: " + language);
    return apiService.fetchVideos(language, context);
  }

  Future<List<LiveContestModel>?> fetchLiveContestCategories(
      BuildContext context) async {
    return apiService.fetchLiveContestCategories(context);
  }

  Future<List<VideoResponse>?> fetchVideosForContest(
      BuildContext context) async {
    return apiService.fetchVideosForContest(context);
  }

  Future<List<VideoResponse>?> fetchVideosForContestByUserAndContestId(
      String userId, String contestId, BuildContext context) async {
    return apiService.fetchVideosForContestByUserAndContestId(
        userId, contestId, context);
  }

  Future<List<String>?> fetchAllLanguages(BuildContext context) async {
    return apiService.fetchAllLanguages(context);
  }

  Future<String?> checkForMainBanner(BuildContext context) async {
    return await apiService.checkForMainBanner(context);
  }

  Future<bool?> likeAndUnlineVideo(
      String videoId, bool status, BuildContext context) async {
    return await apiService.likeAndUnlineVideo(videoId, status, context);
  }

  Future<List<ReportModel>?> fetchReportsList(BuildContext context) async {
    return apiService.fetchReportsList(context);
  }

  Future<List<ReportModel>?> fetchNotInterestedList(
      BuildContext context) async {
    return apiService.fetchNotInterestList(context);
  }

  Future<bool?> watchLater(String videoId, BuildContext context) async {
    return apiService.watchLaterVideo(videoId, context);
  }

  Future<bool?> removeFromWatchLater(
      String videoId, BuildContext context) async {
    return apiService.removeFromWatchList(videoId, context);
  }

  Future<bool?> reportVideo(
      String videoId, String reportId, BuildContext context) async {
    return apiService.reportVideo(videoId, reportId, context);
  }

  Future<bool?> notIntrestedVideo(
      String videoId, String notIntrestedId, BuildContext context) async {
    return apiService.notIntrestedVideo(videoId, notIntrestedId, context);
  }

  Future<void> saveVideo(String videoPath) async {
    try {
      EasyLoading.show(
          indicator:
              const CircularProgressIndicator(color: AppColors.primaryColor),
          status: 'loading...',
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: false);
      final dir = await getTemporaryDirectory();
      String savePath =
          "${dir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4";
      String fileUrl = videoPath;

      await Dio().download(
        fileUrl,
        savePath,
        options: Options(
          sendTimeout: const Duration(minutes: 10),
          receiveTimeout: const Duration(minutes: 10),
        ),
        onReceiveProgress: (count, total) {},
      );

      await SaverGallery.saveFile(
        filePath: savePath,
        fileName: "${DateTime.now().millisecondsSinceEpoch}.mp4",
        androidRelativePath: "Movies",
        skipIfExists: true,
      );
      EasyLoading.dismiss();
      appToast(msg: "Videos saved successfully");
    } catch (e) {
      EasyLoading.dismiss();
      appToast(msg: 'Error: $e');
    }
  }

  Future<bool?> addComment(String videoId, String comment) async {
    Map<String, dynamic> data = {
      FirebaseDocumentKeys.auditionid:
          UserSingleton().userData?.auditionId ?? "",
      FirebaseDocumentKeys.comment: comment,
      FirebaseDocumentKeys.commentBy: UserSingleton().userData?.name ?? "",
      FirebaseDocumentKeys.commentId: const Uuid().v4(),
      FirebaseDocumentKeys.createdAt:
          DateFormat("d MMMM yyyy h:mm a").format(DateTime.now()),
      FirebaseDocumentKeys.postId: videoId,
      FirebaseDocumentKeys.userId: UserSingleton().userData?.id ?? "",
      FirebaseDocumentKeys.userimage: UserSingleton().userData?.image ?? "",
    };

    try {
      await firestoreService.addDocument(
          FirebaseCollections.firebaseCommentCollection, data);
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }

  Future<List<PostComments?>?> viewAllCommentsByPostId(String videoId) async {
    try {
      return await firestoreService.getAllDocumentsByKeyValue(
          FirebaseCollections.firebaseCommentCollection,
          FirebaseDocumentKeys.postId,
          videoId);
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }
}
