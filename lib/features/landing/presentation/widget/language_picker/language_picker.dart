import 'package:audition/core/data/app_storage.dart';
import 'package:audition/core/network/server_keys/app_storage_keys.dart';
import 'package:audition/features/home/domain/home_services.dart';
import 'package:audition/features/landing/presentation/widget/language_picker/language_listing.dart';
import 'package:audition/features/onboarding/presentation/widget/app_button.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class LanguagePicker extends StatefulWidget {
  final Function(String) onLanguageSelect;
  const LanguagePicker({super.key, required this.onLanguageSelect});

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  var selectedIndex = 0;
  Future<List<String>?>? allLanguages;
  HomeServices homeServices = HomeServices();
  var language = "";
  @override
  void initState() {
    fetchLanguages();
    allLanguages = homeServices.fetchAllLanguages(context);
    super.initState();
  }

  fetchLanguages() async {
    var newLanguage =
        await AppStorage.getStorageValueString(AppStorageKeys.langauge);
    if (newLanguage != null) {
      language = newLanguage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: allLanguages,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const SizedBox.shrink();
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var allLanguages = snapshot.data;
              if (language.isEmpty) {
                selectedIndex = 0;
              } else {
                selectedIndex = allLanguages!.indexOf(language);
              }
              return Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: AppColors.backgroundGradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    children: [
                      Text(AppString.selectLanguage,
                          style: CustomTextStyle.headerTextStyle()),
                      Text(AppString.selectLanguageDesc,
                          style: CustomTextStyle.descTextStyle()),
                      10.verticalSpace,
                      Expanded(
                          child: LanguageListing(
                              onLanguageSelect: (p0, p1) =>
                                  widget.onLanguageSelect(p0),
                              allLanguages: allLanguages ?? [],
                              selectedIndex: selectedIndex)),
                      SizedBox(
                          width: double.infinity,
                          child: AppButton(
                              title: AppString.confirm,
                              isDisable: false,
                              onTap: () {
                                Navigator.pop(context);
                              }))
                    ],
                  ));
            }
        }
      },
    );
  }
}
