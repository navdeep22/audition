import 'package:audition/features/home/presentation/widgets/round_buttons.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final Function(bool) isLiveContestSelected;
  final bool isEnable;
  const HomeHeader(
      {super.key, required this.isLiveContestSelected, required this.isEnable});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(17, 2, 17, 17),
        child: Row(children: [
          const Spacer(),
          RoundButtons(
              isSelected: isEnable,
              title: "For your",
              onTap: (text) {
                isLiveContestSelected(false);
              }),
          RoundButtons(
              isSelected: !isEnable,
              title: "Live Contest",
              onTap: (text) {
                isLiveContestSelected(true);
              }),
          const Spacer(),
          IconButton(
              onPressed: () =>
                  AppNavigator.navigateToNotificationScreen(context),
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 28,
              ))
        ]),
      ),
    );
  }
}
