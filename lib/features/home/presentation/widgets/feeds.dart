import 'package:audition/core/data/app_singleton/login_singleton.dart';
import 'package:audition/core/data/app_toast.dart';
import 'package:audition/features/home/domain/home_services.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/home/presentation/widgets/legends/comments/comment_sheet.dart';
import 'package:audition/features/home/presentation/widgets/home_videos.dart';
import 'package:audition/features/home/presentation/widgets/legends/feed_more.dart';
import 'package:audition/features/home/presentation/widgets/legends/feed_share.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/profile/domain/profile_services.dart';
import 'package:audition/resources/app_constants/app_images.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class Feeds extends StatefulWidget {
  final VideoResponse? videoResponse;
  const Feeds({super.key, required this.videoResponse});

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  HomeServices homeServices = HomeServices();
  ProfileServices profileServices = ProfileServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Stack(
        children: [
          HomeVideos(videoUrl: widget.videoResponse?.file),
          Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Column(
                    children: [
                      5.verticalSpace,
                      GestureDetector(
                        onTap: likeUnlikeBtnPressed,
                        child: legends(
                            (widget.videoResponse?.likeStatus ?? false)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            AppFunctions.numberFormat(
                                widget.videoResponse?.likeCount ?? 0)),
                      ),
                      GestureDetector(
                        onTap: commentBtnPressed,
                        child: legends(
                            Icons.message_outlined,
                            AppFunctions.numberFormat(
                                widget.videoResponse?.comment?.length ?? 0)),
                      ),
                      legends(
                          Icons.remove_red_eye_outlined,
                          AppFunctions.numberFormat(
                              widget.videoResponse?.views ?? 0)),
                      GestureDetector(
                          onTap: shareBtnPressed,
                          child: legends(Icons.share, "")),
                      GestureDetector(
                          onTap: moreBtnPressed,
                          child: legends(Icons.more_horiz_sharp, "")),
                      12.verticalSpace,
                    ],
                  ),
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AppNavigator.navigateToOtherUserProfileScreen(
                            widget.videoResponse ?? VideoResponse(), context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(AppIcons.homeBNIcon, height: 25),
                              10.horizontalSpace,
                              Text(widget.videoResponse?.auditionId ?? "",
                                  style: CustomTextStyle
                                      .subTitleWithBoldTextStyle())
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.67,
                            child: Text(widget.videoResponse?.caption ?? "",
                                style: CustomTextStyle
                                    .subTitleWithBoldTextStyle()),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.67,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.sensors_rounded,
                                  color: Colors.white,
                                ),
                                5.horizontalSpace,
                                Image.asset(AppIcons.homeBNIcon, height: 18),
                                5.horizontalSpace,
                                widget.videoResponse?.song == null
                                    ? Text("Audio Not Available",
                                        style: CustomTextStyle.descTextStyle())
                                    : Flexible(
                                        child: Text(
                                            maxLines: 2,
                                            (widget.videoResponse?.song
                                                        ?.byUser ??
                                                    true)
                                                ? "Original sound by ${widget.videoResponse?.song?.userDetails?.auditionId}"
                                                : "${widget.videoResponse?.song?.track}-${widget.videoResponse?.song?.title}",
                                            style: CustomTextStyle
                                                .descTextStyle()),
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        followUser(widget.videoResponse?.userId ?? "",
                            widget.videoResponse?.followStatus ?? false);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 2, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1.5,
                              color: Colors.white,
                            )),
                        child: Text(
                          (widget.videoResponse?.followStatus ?? false)
                              ? AppString.unfollow
                              : AppString.follow,
                          style: CustomTextStyle.subTitleWithBoldTextStyle(),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void followUser(String userId, bool status) async {
    if (LoginSingleton().isGuestUser) {
      appToast(msg: AppString.guestUserError);
      return;
    }
    var userStatus =
        await profileServices.followUnfollowUser(userId, !status, context);
    if (userStatus ?? false) {
      widget.videoResponse?.followStatus = !widget.videoResponse!.followStatus!;
      setState(() {});
    }
  }

  moreBtnPressed() {
    AppFunctions.openBottomSheet(
        context, FeedMore(videoResponse: widget.videoResponse!));
  }

  shareBtnPressed() {
    AppFunctions.openBottomSheet(context, const FeedShare());
  }

  commentBtnPressed() {
    AppFunctions.openBottomSheet(context,
        CommentSheet(videoResponse: widget.videoResponse ?? VideoResponse()));
  }

  likeUnlikeBtnPressed() {
    if (LoginSingleton().isGuestUser) {
      appToast(msg: AppString.guestUserError);
      return;
    }
    homeServices.likeAndUnlineVideo(widget.videoResponse?.id ?? "",
        widget.videoResponse?.likeStatus == false ? true : false, context);
    setState(() {
      widget.videoResponse?.likeStatus = !widget.videoResponse!.likeStatus!;
      if (widget.videoResponse?.likeStatus == true) {
        widget.videoResponse?.likeCount =
            (widget.videoResponse?.likeCount ?? 0) + 1;
      } else {
        widget.videoResponse?.likeCount =
            (widget.videoResponse?.likeCount ?? 0) - 1;
      }
    });
  }

  Widget legends(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 8, 6, 0),
      child: Container(
          width: 44,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(6),
          child: Column(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: title.isNotEmpty ? 27 : 29,
              ),
              if (title.isNotEmpty)
                Text(title, style: CustomTextStyle.descTextStyle())
            ],
          )),
    );
  }
}
