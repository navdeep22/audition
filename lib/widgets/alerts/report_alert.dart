import 'package:audition/features/onboarding/presentation/widget/app_button.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class ReportAlert extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function(bool) onTap;
  const ReportAlert(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          10.verticalSpace,
          const Icon(
            Icons.error_outline,
            size: 50,
          ),
          10.verticalSpace,
          Text(title,
              style: const TextStyle(color: Colors.black, fontSize: 16)),
          10.verticalSpace,
          Text(subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 14)),
          10.verticalSpace,
          Row(
            children: [
              Expanded(
                child: AppButton(
                    title: AppString.yes,
                    isDisable: false,
                    onTap: () {
                      onTap(true);
                    }),
              ),
              Expanded(
                child: AppButton(
                    title: AppString.no,
                    isDisable: false,
                    onTap: () {
                      onTap(false);
                    }),
              )
            ],
          )
        ]),
      ),
    );
  }
}
