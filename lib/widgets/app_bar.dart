import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:flutter/material.dart';

class GlobalAppBar extends StatelessWidget {
  final Widget child;
  final String title;
  final bool paddingOptional;
  final Widget? suffixIcon;
  const GlobalAppBar(
      {super.key,
      required this.child,
      required this.paddingOptional,
      required this.title,
      this.suffixIcon});

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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.appTextColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              title,
              style:
                  const TextStyle(color: AppColors.appTextColor, fontSize: 18),
            ),
            actions: [suffixIcon ?? const SizedBox.shrink()],
          ),
          backgroundColor: Colors.transparent,
          body: Container(
              padding: EdgeInsets.all(paddingOptional ? 18 : 0), child: child),
        )));
  }
}
