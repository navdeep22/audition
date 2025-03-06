import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class HomeVideos extends StatefulWidget {
  final String? videoUrl;
  const HomeVideos({super.key, required this.videoUrl});

  @override
  State<HomeVideos> createState() => _HomeVideosState();
}

class _HomeVideosState extends State<HomeVideos> {
  late BetterPlayerController _betterPlayerController;
  bool _isPlaying = true;
  @override
  void initState() {
    super.initState();

    final BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoUrl!,
      cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
      bufferingConfiguration: const BetterPlayerBufferingConfiguration(
        minBufferMs: 30000,
        maxBufferMs: 100000,
        bufferForPlaybackMs: 2500,
        bufferForPlaybackAfterRebufferMs: 5000,
      ),
    );

    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        overlay: GestureDetector(
            onTap: _togglePlayPause,
            child: Container(
              color: Colors.transparent,
            )),
        autoPlay: true,
        looping: true,
        aspectRatio: 8 / 16,
        controlsConfiguration: const BetterPlayerControlsConfiguration(
            enablePlayPause: false,
            enableFullscreen: false,
            showControls: false),
      ),
      betterPlayerDataSource: dataSource,
    );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(controller: _betterPlayerController);
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _betterPlayerController.pause();
    } else {
      _betterPlayerController.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }
}
