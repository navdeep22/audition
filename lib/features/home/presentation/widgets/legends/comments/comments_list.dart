import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/onboarding/presentation/widget/app_text.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/cache_images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentsList extends StatelessWidget {
  final List<PostComments?> comment;

  const CommentsList({super.key, required this.comment});
  @override
  Widget build(BuildContext context) {
    return comment.isEmpty
        ? Center(
            child: AppText(
                title: AppString.noCommentFound,
                style: CustomTextStyle.subTitleTextStyle()),
          )
        : ListView.builder(
            itemCount: comment.length,
            itemBuilder: (context, index) {
              var commentData = comment[index];
              return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: ContainerStyle.cornerRadiusWithColor(
                      7, AppColors.primaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: (commentData?.userImage ?? "").isNotEmpty
                                  ? SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: CacheImages(
                                          imagePath:
                                              commentData?.userImage ?? ""),
                                    )
                                  : const Icon(
                                      FontAwesomeIcons.solidCircleUser,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                            ),
                            10.horizontalSpace,
                            Flexible(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(commentData?.commentBy ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        style: CustomTextStyle
                                            .appButtonTextStyle()),
                                    Text(commentData?.comment ?? "",
                                        style:
                                            CustomTextStyle.smallTextStyle()),
                                  ]),
                            ),
                            5.horizontalSpace,
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(commentData?.createdAt ?? "",
                            style: const TextStyle(
                                color: Colors.yellow, fontSize: 11)),
                      ),
                    ],
                  ));
            });
  }
}
