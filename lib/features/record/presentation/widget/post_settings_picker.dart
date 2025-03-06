import 'package:audition/features/onboarding/presentation/widget/app_button.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class PostSettingsPicker extends StatefulWidget {
  final bool allowComments;
  final bool allowSharing;
  final bool allowDuet;
  final Function(bool, bool, bool) onSettingApply;
  const PostSettingsPicker({
    super.key,
    required this.allowComments,
    required this.allowSharing,
    required this.allowDuet,
    required this.onSettingApply,
  });

  @override
  State<PostSettingsPicker> createState() => _PostSettingsPickerState();
}

class _PostSettingsPickerState extends State<PostSettingsPicker> {
  bool? allowComments;
  bool? allowSharing;
  bool? allowDuet;

  @override
  void initState() {
    allowComments = widget.allowComments;
    allowSharing = widget.allowSharing;
    allowDuet = widget.allowDuet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: AppColors.backgroundGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Column(
          children: [
            Text(AppString.postSettings,
                style: CustomTextStyle.headerTextStyle()),
            10.verticalSpace,
            ListTile(
                leading: const Icon(Icons.message, color: Colors.white),
                title: Text(AppString.allowComment,
                    style: CustomTextStyle.subTitleTextStyle()),
                trailing: Switch(
                    value: allowComments ?? false,
                    onChanged: (value) {
                      setState(() {
                        allowComments = value;
                      });
                    })),
            ListTile(
                leading: const Icon(Icons.share, color: Colors.white),
                title: Text(AppString.allowSharing,
                    style: CustomTextStyle.subTitleTextStyle()),
                trailing: Switch(
                    value: allowSharing ?? false,
                    onChanged: (value) {
                      setState(() {
                        allowSharing = value;
                      });
                    })),
            ListTile(
                leading: const Icon(Icons.face, color: Colors.white),
                title: Text(AppString.allowDuet,
                    style: CustomTextStyle.subTitleTextStyle()),
                trailing: Switch(
                    value: allowDuet ?? false,
                    onChanged: (value) {
                      setState(() {
                        allowDuet = value;
                      });
                    })),
            SizedBox(
                width: double.infinity,
                child: AppButton(
                    title: AppString.save,
                    isDisable: false,
                    onTap: () {
                      widget.onSettingApply(allowComments ?? false,
                          allowSharing ?? false, allowDuet ?? false);
                      Navigator.pop(context);
                    }))
          ],
        ));
  }
}
