import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppGreenButton extends StatelessWidget {
  final String title;
  final bool isDisable;
  final Function() onTap;
  const AppGreenButton(
      {super.key,
      required this.title,
      required this.isDisable,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: Card(
                color: isDisable
                    ? AppColors.appDisableColor[800]
                    : AppColors.appGreenColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
