import 'dart:io';

import 'package:audition/features/account_verification/presentation/pages/account_verification_screen.dart';
import 'package:audition/features/contests/challenges/domain/model/challenge_response_model.dart';
import 'package:audition/features/contests/challenges/presentation/pages/contest_details_screen.dart';
import 'package:audition/features/contests/challenges/presentation/pages/contest_terms_condition.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/home/presentation/feed_page.dart';
import 'package:audition/features/landing/presentation/pages/landing_screen.dart';
import 'package:audition/features/notifications/presentation/pages/notification_screen.dart';
import 'package:audition/features/onboarding/presentation/pages/login_screen.dart';
import 'package:audition/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:audition/features/profile/model/user_full_details_model.dart';
import 'package:audition/features/profile/presentation/pages/blocked_users.dart';
import 'package:audition/features/profile/presentation/pages/chat_list_screen.dart';
import 'package:audition/features/profile/presentation/pages/edit_user_profile_screen.dart';
import 'package:audition/features/profile/presentation/pages/follow_unfollow_screen.dart';
import 'package:audition/features/profile/presentation/pages/other_user_profile.dart';
import 'package:audition/features/profile/presentation/pages/webview_page.dart';
import 'package:audition/features/record/model/all_music_response_model.dart';
import 'package:audition/features/record/presentation/pages/all_music_screen.dart';
import 'package:audition/features/record/presentation/pages/create_post_dart.dart';
import 'package:audition/features/record/presentation/pages/new_post_location.dart';
import 'package:audition/features/record/presentation/pages/video_trimmer.dart';
import 'package:audition/features/record/presentation/pages/view_recorded_video_screen.dart';
import 'package:audition/features/search/domain/model/search_result_response_model.dart';
import 'package:audition/features/search/presentation/pages/hastag_details_screen.dart';
import 'package:audition/features/wallet/presentation/pages/add_cash_screen.dart';
import 'package:audition/features/wallet/presentation/pages/all_transactions_screen.dart';
import 'package:audition/features/wallet/presentation/pages/wallet_screen.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static navigateToOnboardingScreen(BuildContext context) async {
    return await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()));
  }

  static navigateToLoginScreen(BuildContext context) async {
    return await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  static navigateToLandingScreen(BuildContext context) async {
    return await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const LandingScreen()));
  }

  static navigateToContestDetailScreen(ChallengesModel challengesModel,
      BuildContext context, bool isCompleted, bool isUpcoming) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContestDetailsScreen(
                  challengesModel: challengesModel,
                  isCompletedContest: isCompleted,
                  isUpcoming: isUpcoming,
                )));
  }

  static navigateToEditProfileScreen(BuildContext context) async {
    return await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const EditUserProfileScreen()));
  }

  static navigateToFollowersFollowingScreen(
      UserData user, BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FollowUnfollowScreen(user: user)));
  }

  static navigateToOtherUserProfileScreen(
      VideoResponse videoResponse, BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                OtherUserProfile(videoResponse: videoResponse)));
  }

  static navigateToHastagDetailsScreen(
      Hashtag hashtag, BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HastagDetailsScreen(hashtag: hashtag)));
  }

  static navigateToNotificationScreen(BuildContext context) async {
    return await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const NotificationScreen()));
  }

  static navigateToAllUploadedMusicScreen(
      BuildContext context, Function(MusicModel) selectedMusciModel) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AllMusicScreen(selectedMusciModel: selectedMusciModel)));
  }

  static navigateToAddCashScreen(
      UserData userData, BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddCashScreen(userData: userData)));
  }

  static navigateToAllTransactionsScreen(BuildContext context) async {
    return await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AllTransactionsScreen()));
  }

  static navigateToLocationSelectionScreen(
      Function(String) onLocationSelected, BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NewPostLocation(locationSelected: onLocationSelected)));
  }

  static navigateToTrimVideoScreen(File videoFile,
      Function(File) onTrimmedVideo, BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoTrimmer(
                  videoFile: videoFile,
                  onTrimmedVideo: onTrimmedVideo,
                )));
  }

  static navigateToNewPostScreen(File videoFile, MusicModel musicModel,
      bool isContest, String contestId, BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreatePostScreen(
                recordedVideo: videoFile,
                musicModel: musicModel,
                isContest: isContest,
                contestId: contestId)));
  }

  static navigateToViewRecordedVideo(File recordedVideo, bool isContest,
      String contestId, BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewRecordedVideoScreen(
                recordedVideo: recordedVideo,
                isContest: isContest,
                contestId: contestId)));
  }

  static navigateToWalletScreen(BuildContext context) async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const WalletScreen()));
  }

  static navigateToVerifyAccountScreen(BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const AccountVerificationScreen()));
  }

  static navigateToChatScreen(BuildContext context) async {
    return await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ChatListScreen()));
  }

  static navigateToContestTermsCondition(BuildContext context) async {
    return await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ContestTermsCondition()));
  }

  static navigateToAppWebViewScreen(
      String title, String url, BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebviewPage(title: title, url: url)));
  }

  static navigateToBlockedUsersScreen(BuildContext context) async {
    return await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const BlockedUsersScreen()));
  }

  static navigateToFeedsScreen(BuildContext context,
      List<VideoResponse>? allVideos, PageController pageController) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                FeedPage(videos: allVideos, pageController: pageController)));
  }
}
