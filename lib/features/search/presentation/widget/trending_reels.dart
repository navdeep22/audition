import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/search/presentation/widget/trending_reels_widget.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:flutter/material.dart';

class TrendingReels extends StatelessWidget {
  final List<VideoResponse>? videos;
  const TrendingReels({super.key, this.videos});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            crossAxisCount: 3,
            childAspectRatio: 0.65));
  }
}
