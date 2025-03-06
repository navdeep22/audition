import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/search/domain/model/search_result_response_model.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/cache_images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchFriendsList extends StatelessWidget {
  final List<UserElement>? userList;
  final Function(UserElement) onUserSelected;
  const SearchFriendsList(
      {super.key, required this.userList, required this.onUserSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: userList?.length,
        itemBuilder: (context, index) {
          var user = userList?[index];
          return GestureDetector(
            onTap: () {
              onUserSelected(user ?? UserElement());
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              decoration: ContainerStyle.appGradientViewContainer(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(40)),
                    child: (user?.image != "")
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: CacheImages(
                              imagePath: user?.image ?? "",
                            ),
                          )
                        : const Icon(
                            FontAwesomeIcons.solidCircleUser,
                            size: 30,
                            color: Colors.white,
                          ),
                  ),
                  10.horizontalSpace,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user?.name ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyle.subTitleTextStyle()),
                        Text("${user?.followersCount ?? "0"} Followers",
                            style: CustomTextStyle.appButtonTextStyle()),
                        Text(user?.auditionId ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.yellow, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
