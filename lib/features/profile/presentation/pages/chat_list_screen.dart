import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
        paddingOptional: true,
        title: AppString.chat,
        child: Center(
            child: Text(AppString.noDataFound,
                style: CustomTextStyle.subTitleTextStyle())));
  }
}
