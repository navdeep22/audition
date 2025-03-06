import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/search/domain/model/search_result_response_model.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchedHashtags extends StatelessWidget {
  final List<Hashtag>? hashtagsList;
  const SearchedHashtags({super.key, required this.hashtagsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: hashtagsList?.length ?? 0,
        itemBuilder: (context, index) {
          var hashtag = hashtagsList?[index];
          return GestureDetector(
            onTap: () {
              AppNavigator.navigateToHastagDetailsScreen(hashtag!, context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              decoration: ContainerStyle.appGradientViewContainer(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.hashtag,
                    color: Colors.white,
                    size: 24,
                  ),
                  10.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hashtag?.name ?? "",
                          style: CustomTextStyle.subTitleTextStyle()),
                      Text("${hashtag?.videos ?? "0"} Videos",
                          style: const TextStyle(
                              color: Colors.yellow, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
