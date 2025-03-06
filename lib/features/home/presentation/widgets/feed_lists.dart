import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/home/presentation/widgets/feeds.dart';
import 'package:flutter/material.dart';

class FeedLists extends StatelessWidget {
  final List<VideoResponse>? videos;
  final PageController pageController;

  const FeedLists({super.key, this.videos, required this.pageController});
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: pageController,
        scrollDirection: Axis.vertical,
        itemCount: videos?.length ?? 0,
        itemBuilder: (context, index) => Feeds(videoResponse: videos?[index]));
  }
}
