import 'package:audition/features/home/presentation/widgets/round_buttons.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class ChallengeHeaderArea extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;
  const ChallengeHeaderArea(
      {super.key, required this.selectedFilter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppString.challenges,
            style: CustomTextStyle.appTextSize(),
          ),
          GestureDetector(
            onTap: () {
              AppNavigator.navigateToContestTermsCondition(context);
            },
            child: const Icon(
              Icons.event_note_rounded,
              color: Colors.white,
            ),
          )
        ],
      ),
      20.verticalSpace,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundButtons(
              isSelected: selectedFilter == AppString.upcoming,
              title: AppString.upcoming,
              onTap: (text) {
                onFilterChanged(text);
              }),
          RoundButtons(
              isSelected: selectedFilter == AppString.live,
              title: AppString.live,
              onTap: (text) {
                onFilterChanged(text);
              }),
          RoundButtons(
              isSelected: selectedFilter == AppString.completed,
              title: AppString.completed,
              onTap: (text) {
                onFilterChanged(text);
              }),
        ],
      )
    ]);
  }
}
