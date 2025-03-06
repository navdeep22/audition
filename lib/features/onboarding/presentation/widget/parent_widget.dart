import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:flutter/material.dart';

class ParentWidget extends StatelessWidget {
  final Widget child;
  final bool paddingOptional;
  const ParentWidget(
      {super.key, required this.child, required this.paddingOptional});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: AppColors.backgroundGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
              padding: EdgeInsets.all(paddingOptional ? 18 : 0), child: child),
        )));
  }
}
