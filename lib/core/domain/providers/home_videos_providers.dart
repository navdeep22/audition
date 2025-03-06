import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:flutter/material.dart';

class HomeVideosProviders extends ChangeNotifier {
  List<VideoResponse>? _allVideos;

  List<VideoResponse>? get allVideos => _allVideos;

  void setAllVideos(List<VideoResponse>? videosList) {
    _allVideos = videosList;
    notifyListeners();
  }

  updateAllVideos(List<VideoResponse>? videosList) {
    _allVideos = videosList;
    notifyListeners();
  }

  appendVideos(List<VideoResponse>? videosList) {
    _allVideos?.addAll(videosList ?? []);
    notifyListeners();
  }
}
