import 'package:audition/features/home/domain/home_services.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/home/presentation/widgets/legends/comments/comment_text_field.dart';
import 'package:audition/features/home/presentation/widgets/legends/comments/comments_list.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/pop_up_widget.dart';
import 'package:flutter/material.dart';

class CommentSheet extends StatefulWidget {
  final VideoResponse videoResponse;
  const CommentSheet({super.key, required this.videoResponse});

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  HomeServices _homeServices = HomeServices();
  Future<List<PostComments?>?>? postComments;
  @override
  void initState() {
    postComments = _homeServices
        .viewAllCommentsByPostId(widget.videoResponse.postId ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
        title: AppString.allComments, child: feedComment());
  }

  Widget feedComment() {
    return Column(
      children: [
        Expanded(
            child: FutureBuilder(
                future: postComments,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const SizedBox.shrink();
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        var commentList = snapshot.data;

                        return commentList!.isEmpty
                            ? Center(
                                child: Text(AppString.noDataFound,
                                    style: CustomTextStyle.subTitleTextStyle()))
                            : CommentsList(comment: commentList);
                      }
                  }
                })),
        10.verticalSpace,
        CommentTextField(comment: widget.videoResponse.comment ?? []),
      ],
    );
  }
}
