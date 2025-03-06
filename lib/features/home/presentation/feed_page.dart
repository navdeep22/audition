import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/home/presentation/widgets/feeds.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  final List<VideoResponse>? videos;
  final PageController pageController;
  const FeedPage({super.key, this.videos, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
        paddingOptional: false,
        title: AppString.videos,
        child: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.vertical,
            itemCount: videos?.length ?? 0,
            itemBuilder: (context, index) =>
                Feeds(videoResponse: videos?[index])));
  }
}
