import 'package:audition/core/data/app_singleton/login_singleton.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/onboarding/presentation/widget/app_textfield.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentTextField extends StatefulWidget {
  final List<Comment> comment;
  const CommentTextField({super.key, required this.comment});

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  final TextEditingController commentTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      5.horizontalSpace,
      ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: const Icon(
          FontAwesomeIcons.solidCircleUser,
          size: 33,
          color: Colors.white,
        ),
      ),
      10.horizontalSpace,
      Expanded(
          child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              decoration: ContainerStyle.cornerRadiusWithColor(
                  7, AppColors.primaryColor),
              height: 45,
              child: AppTextfield(
                  controller: commentTextController,
                  hintText: AppString.commentTextFieldHint))),
      10.horizontalSpace,
      GestureDetector(
        onTap: () {
          if (LoginSingleton().isGuestUser) {
            AppNavigator.navigateToOnboardingScreen(context);
          } else {}
        },
        child: const Icon(
          Icons.send,
          size: 26,
          color: Colors.white,
        ),
      ),
      5.horizontalSpace,
    ]);
  }
}
