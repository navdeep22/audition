import 'dart:io';
import 'package:audition/features/onboarding/presentation/widget/app_red_button.dart';
import 'package:audition/features/record/model/all_music_response_model.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class ViewRecordedVideoScreen extends StatefulWidget {
  File recordedVideo;
  final bool isContest;
  final String contestId;
  ViewRecordedVideoScreen(
      {super.key,
      required this.recordedVideo,
      required this.isContest,
      required this.contestId});

  @override
  State<ViewRecordedVideoScreen> createState() =>
      _ViewRecordedVideoScreenState();
}

class _ViewRecordedVideoScreenState extends State<ViewRecordedVideoScreen> {
  late VideoPlayerController _controller;
  MusicModel? musicModel;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    initializeVideoPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SafeArea(
              child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: AppRedButton(
                    title: AppString.nextStep,
                    onTap: () {
                      _controller.pause();
                      AppNavigator.navigateToNewPostScreen(
                          widget.recordedVideo,
                          musicModel ?? MusicModel(),
                          widget.isContest,
                          widget.contestId,
                          context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            _controller.pause();
                            AppNavigator.navigateToAllUploadedMusicScreen(
                                context, (selectedMusicModel) {
                              musicModel = selectedMusicModel;
                            });
                          },
                          icon: const Icon(Icons.music_video_outlined,
                              size: 36, color: Colors.white)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.speed,
                              size: 36, color: Colors.white)),
                      IconButton(
                          onPressed: () {
                            _controller.pause();
                            AppNavigator.navigateToTrimVideoScreen(
                                widget.recordedVideo, (updatedFile) {
                              setState(() {
                                widget.recordedVideo = updatedFile;
                                initializeVideoPlayer();
                              });
                            }, context);
                          },
                          icon: const Icon(Icons.cut,
                              size: 36, color: Colors.white))
                    ],
                  ),
                ),
                150.verticalSpace
              ],
            ),
          ))
        ],
      ),
    );
  }

  void initializeVideoPlayer() {
    _controller = VideoPlayerController.file(widget.recordedVideo);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.pause();
    _controller.dispose();
  }
}
