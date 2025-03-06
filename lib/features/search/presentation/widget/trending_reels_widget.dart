import 'dart:io';

import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/onboarding/presentation/widget/app_text.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class TrendingReelsWidget extends StatefulWidget {
  final VideoResponse? videoData;
  const TrendingReelsWidget({super.key, required this.videoData});

  @override
  State<TrendingReelsWidget> createState() => _TrendingReelsWidgetState();
}

class _TrendingReelsWidgetState extends State<TrendingReelsWidget> {
  String? imageUrl;
  @override
  void initState() {
    generateThumbnail(widget.videoData!.file!).then((onValue) {
      if (mounted) {
        setState(() {
          imageUrl = onValue;
        });
      }
    });
    super.initState();
  }

  Future<String?> generateThumbnail(String videoPath) async {
    try {
      return await AppFunctions().generateThumbnailFromUrl(videoPath);
    } catch (e) {
      debugPrint("Error generating thumbnail: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: FileImage(
                File(imageUrl ?? ""),
              ))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          5.verticalSpace,
          Row(
            children: [
              const Spacer(),
              AppText(
                  style: CustomTextStyle.descWithBolTextStyle(),
                  title:
                      AppFunctions.numberFormat(widget.videoData?.views ?? 0)),
              const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 18,
              ),
              5.horizontalSpace
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(5),
            child: AppText(
                style: CustomTextStyle.smallTextStyle(),
                title: widget.videoData?.auditionId ?? ""),
          ),
        ],
      ),
    ));
  }
}
