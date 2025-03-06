import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppRedButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  const AppRedButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: Card(
                color: AppColors.appBackgroundColor,
                child: Center(
                  child: Text(title,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15)),
                )),
          ),
        ),
      ),
    );
  }
}
