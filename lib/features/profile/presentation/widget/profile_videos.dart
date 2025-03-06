import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/search/presentation/widget/trending_reels_widget.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:flutter/material.dart';

class ProfileVideos extends StatelessWidget {
  final List<VideoResponse>? videos;
  const ProfileVideos({super.key, this.videos});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videos?.length ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                AppNavigator.navigateToFeedsScreen(
                    context, videos, PageController(initialPage: index));
              },
              child: TrendingReelsWidget(videoData: videos?[index]));
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            crossAxisCount: 3,
            childAspectRatio: 0.7));
  }
}
