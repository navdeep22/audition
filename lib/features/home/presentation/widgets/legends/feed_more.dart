import 'package:audition/features/home/domain/home_services.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/home/presentation/widgets/legends/feed_not_interested.dart';
import 'package:audition/features/home/presentation/widgets/legends/feed_report.dart';
import 'package:audition/features/onboarding/presentation/widget/app_button.dart';
import 'package:audition/features/onboarding/presentation/widget/app_text.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/pop_up_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FeedMore extends StatefulWidget {
  VideoResponse videoResponse;
  FeedMore({super.key, required this.videoResponse});

  @override
  State<FeedMore> createState() => _FeedMoreState();
}

class _FeedMoreState extends State<FeedMore> {
  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
        title: AppString.more, child: feedMoreData(context));
  }

  feedMoreData(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: AppButton(
                    title: AppString.download,
                    isDisable: false,
                    onTap: () {
                      HomeServices().saveVideo(widget.videoResponse.file ?? "");
                    })),
            Expanded(
                child: AppButton(
                    title: widget.videoResponse.isSaved!
                        ? AppString.removeFromWatchLater
                        : AppString.watchLater,
                    isDisable: false,
                    onTap: () {
                      if (widget.videoResponse.isSaved ?? false) {
                        HomeServices().removeFromWatchLater(
                            widget.videoResponse.id ?? "", context);
                      } else {
                        HomeServices()
                            .watchLater(widget.videoResponse.id ?? "", context);
                      }

                      widget.videoResponse.isSaved =
                          !widget.videoResponse.isSaved!;
                      setState(() {});
                    }))
          ],
        ),
        20.verticalSpace,
        Row(
          children: [
            // GestureDetector(
            //   onTap: () {},
            //   child: Column(
            //     children: [
            //       const Center(
            //         child: Padding(
            //           padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            //           child: SizedBox(
            //             width: 70,
            //             height: 70,
            //             child: Card(
            //                 color: Colors.white,
            //                 child: Padding(
            //                   padding: EdgeInsets.all(8.0),
            //                   child: Icon(Icons.face),
            //                 )),
            //           ),
            //         ),
            //       ),
            //       AppText(
            //           title: AppString.duet,
            //           style: CustomTextStyle.appButtonTextStyle())
            //     ],
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                notInterestedBtnPressed(context);
              },
              child: Column(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.heart_broken),
                            )),
                      ),
                    ),
                  ),
                  AppText(
                      title: AppString.notInterested,
                      style: CustomTextStyle.appButtonTextStyle())
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                reportBtnPressed(context);
              },
              child: Column(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.report),
                            )),
                      ),
                    ),
                  ),
                  AppText(
                      title: AppString.report,
                      style: CustomTextStyle.appButtonTextStyle())
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  notInterestedBtnPressed(BuildContext context) {
    AppFunctions.openBottomSheet(
        context, FeedNotInterested(videoResponse: widget.videoResponse));
  }

  reportBtnPressed(BuildContext context) {
    AppFunctions.openBottomSheet(context,
        FeedReport(videoResponse: widget.videoResponse, reportUser: false));
  }

  duetBtnPressed(BuildContext context) {}
}
