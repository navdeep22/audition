import 'package:audition/features/home/domain/home_services.dart';
import 'package:audition/features/home/model/get_live_contest_response_model.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/cache_images.dart';
import 'package:flutter/widgets.dart';

class LiveContestsHome extends StatefulWidget {
  const LiveContestsHome({super.key});

  @override
  State<LiveContestsHome> createState() => _LiveContestsHomeState();
}

class _LiveContestsHomeState extends State<LiveContestsHome> {
  Future<List<LiveContestModel>?>? liveContests;
  HomeServices homeServices = HomeServices();

  @override
  void initState() {
    liveContests = homeServices.fetchLiveContestCategories(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: AppColors.backgroundGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: FutureBuilder(
            future: liveContests,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const SizedBox.shrink();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    var contestCategory = snapshot.data;
                    return ListView.builder(
                        itemCount: contestCategory?.length ?? 0,
                        itemBuilder: (context, index) {
                          var contestCat = contestCategory?[index];
                          return GestureDetector(
                            onTap: () async {
                              await homeServices
                                  .fetchVideosForContest(context)
                                  .then((onValue) {
                                AppNavigator.navigateToFeedsScreen(context,
                                    onValue, PageController(initialPage: 0));
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(
                                    bottom: 10, left: 10, right: 10),
                                decoration:
                                    ContainerStyle.appGradientViewContainer(5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CacheImages(
                                            imagePath:
                                                AppFunctions.createImageLink(
                                                    contestCat?.file ?? "")),
                                      ),
                                    ),
                                    10.horizontalSpace,
                                    Text(contestCat?.contestName ?? "",
                                        style: CustomTextStyle.appTextSize()),
                                  ],
                                )),
                          );
                        });
                  }
              }
            }),
      ),
    );
  }
}
