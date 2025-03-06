import 'package:audioplayers/audioplayers.dart';
import 'package:audition/features/home/presentation/widgets/round_buttons.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/record/domain/record_services.dart';
import 'package:audition/features/record/model/all_music_response_model.dart';
import 'package:audition/features/record/presentation/widget/all_music_list.dart';
import 'package:audition/features/search/presentation/widget/search_bar.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class AllMusicScreen extends StatefulWidget {
  final Function(MusicModel) selectedMusciModel;
  const AllMusicScreen({super.key, required this.selectedMusciModel});

  @override
  State<AllMusicScreen> createState() => _AllMusicScreenState();
}

class _AllMusicScreenState extends State<AllMusicScreen> {
  Future<List<MusicModel>?>? musicList;
  Future<List<MusicModel>?>? savedMusicList;
  RecordServices recordServices = RecordServices();
  bool isLibrarySelected = true;
  var searchString = "";
  final player = AudioPlayer();
  @override
  void initState() {
    musicList = recordServices.getAllUploadedMusic(context);
    savedMusicList = recordServices.getAllSavedMusic(context);
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
        child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 10, bottom: 10),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.chevron_left,
                            color: Colors.white, size: 30)),
                    Expanded(
                      child: SearchField(
                        controller: TextEditingController(text: searchString),
                        searchReels: (newSearchString) {
                          searchString = newSearchString;

                          setState(() {});
                        },
                        clearData: () {
                          searchString = "";
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              10.verticalSpace,
              Row(children: [
                const Spacer(),
                RoundButtons(
                    isSelected: isLibrarySelected,
                    title: "Library",
                    onTap: (text) {
                      setState(() {
                        isLibrarySelected = true;
                      });
                    }),
                20.horizontalSpace,
                RoundButtons(
                    isSelected: !isLibrarySelected,
                    title: "Saved",
                    onTap: (text) {
                      setState(() {
                        isLibrarySelected = false;
                      });
                    }),
                const Spacer(),
              ]),
              if (isLibrarySelected)
                Expanded(
                  child: FutureBuilder(
                      future: musicList,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const SizedBox.shrink();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              var musicData = snapshot.data
                                  ?.where((test) =>
                                      test.title!.contains(searchString))
                                  .toList();

                              return musicData!.isEmpty
                                  ? Center(
                                      child: Text(AppString.noDataFound,
                                          style: CustomTextStyle
                                              .subTitleTextStyle()))
                                  : AllMusicList(
                                      musicList: musicData,
                                      playMusic: (musicModel) async {
                                        if (musicModel.isPlaying ?? false) {
                                          player.stop();
                                          setState(() {
                                            musicData
                                                    .firstWhere(
                                                        (test) =>
                                                            test.id ==
                                                            musicModel.id)
                                                    .isPlaying =
                                                !musicModel.isPlaying!;
                                          });
                                          return;
                                        }
                                        player.stop();
                                        for (var item in musicData) {
                                          item.isPlaying = false;
                                        }
                                        await player.play(UrlSource(
                                            AppFunctions.createImageLink(
                                                "/${musicModel.file}")));
                                        setState(() {
                                          musicData
                                                  .firstWhere((test) =>
                                                      test.id == musicModel.id)
                                                  .isPlaying =
                                              !musicModel.isPlaying!;
                                        });
                                      },
                                      addFav: (musicModel) {
                                        recordServices
                                            .addMusicAsFav(
                                                musicModel.id ?? "", context)
                                            .then((onValue) {
                                          setState(() {
                                            musicData
                                                .firstWhere((test) =>
                                                    test.id == musicModel.id)
                                                .isFav = true;
                                          });
                                        });
                                      },
                                    );
                            }
                        }
                      }),
                ),
              if (!isLibrarySelected)
                Expanded(
                  child: FutureBuilder(
                      future: savedMusicList,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const SizedBox.shrink();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              var musicData = snapshot.data
                                  ?.where((test) =>
                                      test.title!.contains(searchString))
                                  .toList();

                              return musicData!.isEmpty
                                  ? Center(
                                      child: Text(AppString.noDataFound,
                                          style: CustomTextStyle
                                              .subTitleTextStyle()))
                                  : AllMusicList(
                                      musicList: musicData,
                                      playMusic: (musicModel) async {
                                        if (musicModel.isPlaying ?? false) {
                                          player.stop();
                                          setState(() {
                                            musicData
                                                    .firstWhere(
                                                        (test) =>
                                                            test.id ==
                                                            musicModel.id)
                                                    .isPlaying =
                                                !musicModel.isPlaying!;
                                          });
                                          return;
                                        }
                                        player.stop();
                                        for (var item in musicData) {
                                          item.isPlaying = false;
                                        }
                                        await player.play(UrlSource(
                                            AppFunctions.createImageLink(
                                                "/${musicModel.file}")));
                                        setState(() {
                                          musicData
                                                  .firstWhere((test) =>
                                                      test.id == musicModel.id)
                                                  .isPlaying =
                                              !musicModel.isPlaying!;
                                        });
                                      },
                                      addFav: (musicModel) {
                                        recordServices
                                            .addMusicAsFav(
                                                musicModel.id ?? "", context)
                                            .then((onValue) {
                                          setState(() {
                                            musicData
                                                .firstWhere((test) =>
                                                    test.id == musicModel.id)
                                                .isFav = true;
                                          });
                                        });
                                      },
                                    );
                            }
                        }
                      }),
                ),
            ],
          ),
        )));
  }

  @override
  void dispose() {
    player.stop();
    super.dispose();
  }
}
