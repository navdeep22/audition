import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/search/domain/model/search_result_response_model.dart';
import 'package:audition/features/search/domain/search_services.dart';
import 'package:audition/features/search/presentation/widget/trending_reels.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HastagDetailsScreen extends StatefulWidget {
  final Hashtag? hashtag;
  const HastagDetailsScreen({super.key, required this.hashtag});

  @override
  State<HastagDetailsScreen> createState() => _HastagDetailsScreenState();
}

class _HastagDetailsScreenState extends State<HastagDetailsScreen> {
  Future<List<VideoResponse>?>? allVideos;
  SearchServices searchServices = SearchServices();
  var searchString = "";

  @override
  void initState() {
    allVideos =
        searchServices.fetchHashtagVideos(widget.hashtag?.name ?? "", context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
        paddingOptional: false,
        title: "",
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.hashtag,
                  color: Colors.white,
                  size: 34,
                ),
                10.horizontalSpace,
                Text(widget.hashtag?.name ?? "",
                    style: CustomTextStyle.headerTextStyle()),
              ],
            ),
            20.verticalSpace,
            Expanded(
                child: FutureBuilder(
                    future: allVideos,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const SizedBox.shrink();
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            var videos = snapshot.data;

                            return TrendingReels(videos: videos);
                          }
                      }
                    }))
          ]),
        ));
  }
}
