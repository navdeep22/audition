import 'package:audition/core/data/app_storage.dart';
import 'package:audition/core/network/server_keys/app_storage_keys.dart';
import 'package:audition/features/home/domain/home_services.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/home/presentation/widgets/feed_lists.dart';
import 'package:audition/features/landing/presentation/widget/language_picker/language_picker.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/widgets/cache_images.dart';
import 'package:flutter/material.dart';

class HomeFeeds extends StatefulWidget {
  const HomeFeeds({super.key});

  @override
  State<HomeFeeds> createState() => _HomeFeedsState();
}

class _HomeFeedsState extends State<HomeFeeds> {
  Future<List<VideoResponse>?>? allVideos;
  HomeServices homeServices = HomeServices();
  var bannerImageLink = "";
  var showBanner = false;
  var language = "hindi";
  var apiCalled = false;
  var appendData = false;
  var initialCount = 0;
  List<VideoResponse>? videos = [];
  PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    fetchHomeFeeds();
    allVideos = homeServices.fetchVideos(language, context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppFunctions.openBottomSheet(context, LanguagePicker(
        onLanguageSelect: (newLanguage) {
          allVideos = homeServices.fetchVideos(newLanguage, context);
        },
      ));
    });

    _pageController.addListener(() {
      if (_pageController.position.pixels <=
          _pageController.position.minScrollExtent - 10) {
        if (!apiCalled) {
          allVideos = homeServices.fetchVideos('hindi', context);
          setState(() {});
        }

        apiCalled = true;
      } else if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent + 10) {
        if (!apiCalled) {
          appendData = true;
          allVideos = homeServices.fetchVideos('hindi', context);
          setState(() {});
        }
      }
    });
  }

  fetchHomeFeeds() async {
    var newLanguage =
        await AppStorage.getStorageValueString(AppStorageKeys.langauge);
    if (newLanguage != null) {
      language = newLanguage;
    }
    homeServices.checkForMainBanner(context).then((onValue) {
      if (onValue != null) {
        if (onValue.isNotEmpty) {
          bannerImageLink = onValue;
          showBanner = true;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
            future: allVideos,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const SizedBox.shrink();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (appendData) {
                      videos!.addAll(snapshot.data!);
                      appendData = false;
                      initialCount = initialCount + 9;
                      _pageController =
                          PageController(initialPage: initialCount);
                    } else {
                      videos = snapshot.data;
                    }
                    apiCalled = false;
                    return FeedLists(
                        videos: videos, pageController: _pageController);
                  }
              }
            }),
        if (showBanner)
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Stack(
                children: [
                  CacheImages(imagePath: bannerImageLink),
                  Positioned(
                    top: 3,
                    right: 3,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showBanner = false;
                        });
                      },
                      child: const Icon(Icons.close,
                          color: Colors.white, size: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
