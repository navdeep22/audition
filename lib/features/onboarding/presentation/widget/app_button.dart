import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final bool isDisable;
  final Function() onTap;
  const AppButton(
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
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: Card(
                color:
                    isDisable ? AppColors.appDisableColor[800] : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 15)),
                )),
          ),
        ),
      ),
    );
  }
}
