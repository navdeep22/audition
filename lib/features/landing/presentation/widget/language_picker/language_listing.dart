import 'package:audition/core/data/app_storage.dart';
import 'package:audition/core/network/server_keys/app_storage_keys.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class LanguageListing extends StatelessWidget {
  final int selectedIndex;
  final List<String> allLanguages;
  final Function(String, int) onLanguageSelect;
  const LanguageListing(
      {super.key,
      required this.selectedIndex,
      required this.allLanguages,
      required this.onLanguageSelect});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: allLanguages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.5,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                onLanguageSelect(allLanguages[index], index);
                AppStorage.saveToStorageString(
                    AppStorageKeys.langauge, allLanguages[index]);
                Navigator.pop(context);
              },
              child: Container(
                  decoration: selectedIndex == index
                      ? BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(7))
                      : ContainerStyle.cornerRadiusWithColor(7, Colors.white),
                  child: Center(
                      child: Text(
                    allLanguages[index].capitalizeFirst(),
                    style: TextStyle(
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.black),
                  ))),
            ));
  }
}
