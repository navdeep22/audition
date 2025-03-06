import 'dart:io';

import 'package:audition/core/network/repository/s3_upload.dart';
import 'package:audition/features/onboarding/presentation/widget/app_green_button.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/record/domain/record_services.dart';
import 'package:audition/features/record/model/all_music_response_model.dart';
import 'package:audition/features/record/presentation/widget/post_settings_picker.dart';
import 'package:audition/features/record/presentation/widget/search_friends_list.dart';
import 'package:audition/features/search/domain/model/search_result_response_model.dart';
import 'package:audition/features/search/domain/search_services.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_trimmer/video_trimmer.dart';

class CreatePostScreen extends StatefulWidget {
  final File recordedVideo;
  final MusicModel musicModel;
  final bool isContest;
  final String contestId;
  const CreatePostScreen(
      {super.key,
      required this.recordedVideo,
      required this.musicModel,
      required this.isContest,
      required this.contestId});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController captionTF = TextEditingController();
  TextEditingController locationTF = TextEditingController();
  TextEditingController hashtagTF = TextEditingController();
  TextEditingController friendsTF = TextEditingController();
  TextEditingController postSettingTF = TextEditingController();
  bool allowComments = true;
  bool allowSharing = true;
  bool allowDuet = true;
  final Trimmer _trimmer = Trimmer();
  Future<SearchData?>? trendingResponse;
  UserElement? selectedUser;
  SearchServices searchServices = SearchServices();
  bool showFriendsList = false;
  String newSearchString = "";
  bool friendSelected = false;
  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.recordedVideo);
  }

  @override
  void initState() {
    super.initState();

    // var audioFile = AppFunctions().extractAudioFromVideo(widget.recordedVideo);
    // print(audioFile);
    _loadVideo();
  }

  searchUsers(String searchString) {
    if (searchString.length > 2 && !friendSelected) {
      newSearchString = searchString;
      trendingResponse =
          searchServices.fetchSearchResult(searchString, context);
      showFriendsList = true;
      FocusScope.of(context).unfocus();
      setState(() {});
    } else {
      showFriendsList = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
        paddingOptional: true,
        title: AppString.createPost,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: 140,
                  height: 180,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: VideoViewer(trimmer: _trimmer)),
              10.verticalSpace,
              legends(
                  Icons.abc,
                  TextField(
                      style: CustomTextStyle.subTitleTextStyle(),
                      controller: captionTF,
                      maxLines: 5,
                      onChanged: (value) {
                        checkFriendsApiCall(value);
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        counter: SizedBox.shrink(),
                        border: InputBorder.none,
                        hintText: AppString.createPostCaptionHint,
                        labelStyle: TextStyle(fontSize: 12),
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                  isCaption: true),
              20.verticalSpace,
              Stack(
                children: [
                  Column(
                    children: [
                      20.verticalSpace,
                      GestureDetector(
                          onTap: () {
                            AppNavigator.navigateToLocationSelectionScreen(
                                (locationSelected) {
                              setState(() {
                                locationTF.text = locationSelected;
                              });
                            }, context);
                          },
                          child: legends(
                              Icons.pin_drop_outlined,
                              TextField(
                                  style: CustomTextStyle.subTitleTextStyle(),
                                  controller: locationTF,
                                  enabled: false,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    counter: SizedBox.shrink(),
                                    border: InputBorder.none,
                                    hintText: AppString.addLocation,
                                    labelStyle: TextStyle(fontSize: 12),
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )))),
                      20.verticalSpace,
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              captionTF.text = "${captionTF.text}#";
                            });
                          },
                          child: legends(
                              FontAwesomeIcons.hashtag,
                              TextField(
                                  style: CustomTextStyle.subTitleTextStyle(),
                                  controller: hashtagTF,
                                  maxLines: 5,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    counter: SizedBox.shrink(),
                                    border: InputBorder.none,
                                    hintText: AppString.hashtags,
                                    labelStyle: TextStyle(fontSize: 12),
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )))),
                      20.verticalSpace,
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              captionTF.text = "${captionTF.text}@";
                            });
                          },
                          child: legends(
                              Icons.people,
                              TextField(
                                  style: CustomTextStyle.subTitleTextStyle(),
                                  controller: friendsTF,
                                  maxLines: 5,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    counter: SizedBox.shrink(),
                                    border: InputBorder.none,
                                    hintText: AppString.friends,
                                    labelStyle: TextStyle(fontSize: 12),
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )))),
                      20.verticalSpace,
                      GestureDetector(
                          onTap: () {
                            AppFunctions.openDynamicBottomSheet(
                                context,
                                PostSettingsPicker(
                                  allowComments: allowComments,
                                  allowDuet: allowDuet,
                                  allowSharing: allowSharing,
                                  onSettingApply: (allowCommentsTemp,
                                      allowDuetTemp, allowSharingTemp) {
                                    allowComments = allowCommentsTemp;
                                    allowDuet = allowDuetTemp;
                                    allowSharing = allowSharingTemp;
                                  },
                                ));
                          },
                          child: legends(
                              Icons.camera_alt_outlined,
                              TextField(
                                  style: CustomTextStyle.subTitleTextStyle(),
                                  controller: postSettingTF,
                                  maxLines: 5,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    counter: SizedBox.shrink(),
                                    border: InputBorder.none,
                                    hintText: AppString.postSettings,
                                    labelStyle: TextStyle(fontSize: 12),
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ))))
                    ],
                  ),
                  if (showFriendsList)
                    FutureBuilder(
                        future: trendingResponse,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const SizedBox.shrink();
                            default:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                var users = snapshot.data?.users;
                                return SearchFriendsList(
                                  userList: users,
                                  onUserSelected: (userElement) {
                                    selectedUser = userElement;
                                    setState(() {
                                      String updatedText = captionTF.text
                                          .replaceAll("@$newSearchString",
                                              selectedUser?.name ?? "");
                                      captionTF.text = updatedText;
                                      showFriendsList = false;
                                      friendSelected = true;
                                      setState(() {});
                                    });
                                  },
                                );
                              }
                          }
                        })
                ],
              ),
              20.verticalSpace,
              AppGreenButton(
                title: "Post",
                onTap: () async {
                  var videoUrl = await S3UploadService()
                      .uploadToDigitalOcean(widget.recordedVideo.path);

                  var postId = await RecordServices().uploadVideoToFirebase(
                      videoUrl ?? "", captionTF.text, "");

                  await RecordServices().uploadVideoToServer(
                      widget.musicModel,
                      locationTF.text,
                      captionTF.text,
                      "",
                      postId ?? "",
                      widget.isContest ? widget.contestId : "",
                      videoUrl ?? "",
                      allowComments,
                      allowDuet,
                      allowSharing,
                      context);

                  AppNavigator.navigateToLandingScreen(context);
                },
                isDisable: false,
              ),
            ],
          ),
        ));
  }

  void checkFriendsApiCall(String text) {
    if (text.trim().isNotEmpty && text.contains("@")) {
      if (getSearchString(text)!.length < 3) {
        friendSelected = false;
      }
      searchUsers(getSearchString(text) ?? "");
    }
  }

  String? getSearchString(String text) {
    RegExp regExp = RegExp(r"@(\w+)");
    Match? match = regExp.firstMatch(text);

    if (match != null) {
      String result = match.group(1)!;
      return result;
    } else {
      return "";
    }
  }

  legends(IconData icon, Widget textController, {bool isCaption = false}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
          )),
      child: Row(
        children: [
          if (!isCaption) ...[
            5.horizontalSpace,
            Icon(
              icon,
              color: AppColors.appTextColor,
              size: 30,
            ),
          ],
          10.horizontalSpace,
          Expanded(
            child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                height: isCaption ? 130 : 45,
                child: textController),
          )
        ],
      ),
    );
  }
}
