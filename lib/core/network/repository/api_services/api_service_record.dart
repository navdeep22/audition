import 'dart:convert';

import 'package:audition/core/data/app_exception.dart';
import 'package:audition/core/data/app_toast.dart';
import 'package:audition/core/network/apiclient.dart';
import 'package:audition/core/network/server_keys/apikeys.dart';
import 'package:audition/core/network/server_keys/app_storage_keys.dart';
import 'package:audition/core/network/server_keys/endpoints.dart';
import 'package:audition/features/record/model/all_music_response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ApiServiceRecord {
  var client = ApiClient();

  Future<List<MusicModel>?> getAllUploadedMusic(BuildContext context) async {
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getMusicUploaded);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      AllMusicUploadedResponseModel allMusicUploadedResponseModel =
          AllMusicUploadedResponseModel.fromJson(json);
      return allMusicUploadedResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<List<MusicModel>?> getAllSavedMusic(BuildContext context) async {
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getFavMusicList);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      AllMusicUploadedResponseModel allMusicUploadedResponseModel =
          AllMusicUploadedResponseModel.fromJson(json);
      return allMusicUploadedResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<bool?> addMusicAsFav(String favMusicId, BuildContext context) async {
    var params = {Apikeys.favMusic: favMusicId};
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.addFavMusic);
    final response = await client.post(url, body: params);
    if (response.statusCode == 200) {
      appToast(msg: "Song added successfully");
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  static Future<void> getLocationResults(String input,
      Function(List<dynamic>) updatePlaceList, BuildContext context) async {
    String sessionToken = const Uuid().toString();
    String type = 'IN';
    String request =
        '${APIEndpoints.googlePlacesUrl}?input=$input&key=${AppStorageKeys.googleMapApiKey}&sessiontoken=$sessionToken&region=$type';

    try {
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        List<dynamic> placeList = json.decode(response.body)['predictions'];
        updatePlaceList(placeList);
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      debugPrint('Error in fetching location results: $e');
    }
  }

  Future<bool?> uploadVideoToServer(
      MusicModel musicModel,
      String location,
      String caption,
      String hashtag,
      String postId,
      String contestId,
      String videoLink,
      bool isAllowComment,
      bool isAllowDuet,
      bool isAllowSharing,
      BuildContext context) async {
    var params = {
      Apikeys.location: location,
      Apikeys.long: "",
      Apikeys.lat: "",
      Apikeys.language: "hindi",
      //   Apikeys.songName: musicModel.title ?? "",

      //Apikeys.songid: musicModel.id ?? "":

      Apikeys.postId: postId,
      //  Apikeys.songLink: musicModel.file ?? "",
      Apikeys.filename: videoLink,
      Apikeys.typename: "",
      //Apikeys.hashtag: hashtag,
      Apikeys.caption: caption,
      Apikeys.isAllowComment: "$isAllowComment",
      Apikeys.isAllowDuet: "$isAllowComment",
      Apikeys.isAllowSharing: "$isAllowComment",
      Apikeys.shares: "0",
      Apikeys.comment: "",
      Apikeys.likeCount: "0",
      Apikeys.userLike: ""
    };

    final url = Uri.parse(
        APIEndpoints.baseUrl + APIEndpoints.uploadNormalVideoToServer);
    final response = await client.post(url, body: params);
    if (response.statusCode == 200) {
      appToast(msg: "Video uploaded successfully");
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
        return false;
      }
    }
    return null;
  }

  Future<bool?> uploadVideoToContest(
      MusicModel musicModel,
      String location,
      String caption,
      String hashtag,
      String postId,
      String contestId,
      String videoLink,
      bool isAllowComment,
      bool isAllowDuet,
      bool isAllowSharing,
      BuildContext context) async {
    var params = {
      Apikeys.location: location,
      Apikeys.long: "",
      Apikeys.lat: "",
      Apikeys.language: "hindi",
      //Apikeys.songName: musicModel.title ?? "",

      //Apikeys.songid: musicModel.id ?? "":

      Apikeys.postId: postId,
      //Apikeys.songLink: musicModel.file ?? "",
      Apikeys.filename: videoLink,
      Apikeys.typename: "",
      //Apikeys.hashtag: hashtag,
      Apikeys.caption: caption,
      Apikeys.isAllowComment: "$isAllowComment",
      Apikeys.isAllowDuet: "$isAllowComment",
      Apikeys.isAllowSharing: "$isAllowComment",
      Apikeys.shares: "0",
      Apikeys.comment: "",
      Apikeys.likeCount: "0",
      Apikeys.userLike: "",
      Apikeys.contestId: contestId,
      Apikeys.status: "contest"
    };

    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.joinContest);
    final response = await client.post(url, body: params);
    if (response.statusCode == 200) {
      appToast(msg: "Contest joined successfully");
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
        return false;
      }
    }
    return null;
  }
}
