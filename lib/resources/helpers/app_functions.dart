import 'dart:io';

import 'package:audition/core/data/app_storage.dart';
import 'package:audition/core/network/server_keys/endpoints.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class AppFunctions {
  static void openBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return child;
        });
  }

  static void openDynamicBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return child;
        });
  }

  static void showDialogueBox(BuildContext context, Widget child) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                    minWidth: 100,
                    maxHeight: 400,
                    minHeight: 100,
                  ),
                  child: child));
        });
  }

  static void showJoinContestDialogueBox(BuildContext context, Widget child) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                    minWidth: 100,
                    maxHeight: 300,
                    minHeight: 100,
                  ),
                  child: child));
        });
  }

  static String timeAgo(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} sec ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else {
      final DateFormat formatter = DateFormat('d MMM, yyyy, HH:mm');
      return formatter.format(dateTime);
    }
  }

  static String dateConverter(DateTime dateTime) {
    final DateFormat formatter = DateFormat('d MMM, HH:mm');
    return formatter.format(dateTime);
  }

  static String createImageLink(String url) {
    return "${APIEndpoints.imageBaseUrl}$url";
  }

  static String numberFormat(int number) {
    if (number < 1000) {
      return number.toString(); // No formatting for numbers below 1000
    } else if (number < 1000000) {
      return '${(number / 1000).toStringAsFixed(1)}k'; // For thousands
    } else if (number < 1000000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M'; // For millions
    } else {
      return '${(number / 1000000000).toStringAsFixed(1)}B'; // For billions
    }
  }

  Future<String> generateThumbnailFromUrl(String videoUrl) async {
    try {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final directory = await getTemporaryDirectory();
      final videoFilePath = '${directory.path}/video_$timestamp.mp4';

      final response = await http.get(Uri.parse(videoUrl));
      final videoFile = File(videoFilePath);
      await videoFile.writeAsBytes(response.bodyBytes);

      var thumbnailPath = '${directory.path}/thumbnail_$timestamp.jpg';

      final command =
          "-i $videoFilePath -ss 00:00:01 -vframes 1 -pix_fmt yuv420p $thumbnailPath";

      // await FFmpegKit.executeAsync(command, (session) async {
      //   final returnCode = await session.getReturnCode();
      //   if (ReturnCode.isSuccess(returnCode)) {
      //     debugPrint('Thumbnail generated at: $thumbnailPath');
      //   } else {
      //     thumbnailPath = "";
      //   }
      // });
      return thumbnailPath;
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
    }
    return "";
  }

  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  static bool isValidatePAN(String pan) {
    final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    return panRegex.hasMatch(pan);
  }

  static logoutUser(BuildContext context) {
    AppStorage.clear();
    AppNavigator.navigateToLoginScreen(context);
  }
}
