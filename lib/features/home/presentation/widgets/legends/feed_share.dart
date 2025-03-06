import 'package:audition/resources/app_constants/app_images.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/widgets/pop_up_widget.dart';
import 'package:flutter/material.dart';

class FeedShare extends StatelessWidget {
  const FeedShare({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(title: AppString.share, child: feedShare());
  }

  Widget feedShare() {
    return Wrap(
      runSpacing: 20,
      spacing: 8,
      children: [
        shareItem(AppImages.share1),
        shareItem(AppImages.share2),
        shareItem(AppImages.share3),
        shareItem(AppImages.share4),
        shareItem(AppImages.share5),
        shareItem(AppImages.share6),
        shareItem(AppImages.share7),
        shareItem(AppImages.share8),
        shareItem(AppImages.more),
      ],
    );
  }

  Widget shareItem(String image) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: SizedBox(
            width: 60, height: 60, child: Image(image: AssetImage(image))),
      ),
    );
  }
}
