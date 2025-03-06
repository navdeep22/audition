import 'dart:io';
import 'package:audition/core/network/repository/api_services/s3_upload/s3_client.dart';
import 'package:flutter/material.dart';

class S3UploadService {
  Future<String?> uploadToDigitalOcean(String filePath) async {
    try {
      return await AwsS3.uploadFile(
          accessKey: "DO008MTQD8K4BEWDB4ZE",
          secretKey: "oo2GMiXgzA09nS/j9UMo84fv4javn8UfWnVLBAiZFFM",
          file: File(filePath),
          bucket: "biggee",
          region: 'blr1',
          contentType: "video/mp4",
          filename: "biggee/video-${getCurrentTimestampFileName("mp4")}");
    } catch (e) {
      debugPrint('Error uploading file: $e');
    }
    return null;
  }

  String getCurrentTimestampFileName(String extension) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return "$timestamp.$extension";
  }
}
