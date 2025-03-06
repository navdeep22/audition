import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/record/model/all_music_response_model.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/cache_images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AllMusicList extends StatelessWidget {
  final List<MusicModel> musicList;
  final Function(MusicModel) playMusic;
  final Function(MusicModel) addFav;
  const AllMusicList(
      {super.key,
      required this.musicList,
      required this.playMusic,
      required this.addFav});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: musicList.length,
        itemBuilder: (context, index) {
          var musicData = musicList[index];
          return musicData.type == "category"
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text((musicData.title ?? "").capitalizeFirst(),
                      style: CustomTextStyle.headerTextStyle()),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  decoration: ContainerStyle.appGradientViewContainer(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: (musicData.image != "")
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CacheImages(
                                      imagePath: AppFunctions.createImageLink(
                                          musicData.image ?? ""),
                                    ),
                                  )
                                : const Icon(
                                    FontAwesomeIcons.solidCircleUser,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                          ),
                          10.horizontalSpace,
                        ],
                      ),
                      Expanded(
                        child: Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(musicData.title ?? "",
                                  maxLines: 2,
                                  style: CustomTextStyle
                                      .subTitleWithBoldTextStyle()),
                              Text(musicData.track ?? "",
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Colors.yellow, fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              playMusic(musicData);
                            },
                            child: Icon(
                              (musicData.isPlaying ?? false)
                                  ? FontAwesomeIcons.pause
                                  : FontAwesomeIcons.play,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                          15.horizontalSpace,
                          GestureDetector(
                              onTap: () {
                                addFav(musicData);
                              },
                              child: Icon(
                                (musicData.isFav ?? false)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 24,
                                color: Colors.white,
                              )),
                          5.horizontalSpace,
                        ],
                      ),
                    ],
                  ),
                );
        });
  }
}
