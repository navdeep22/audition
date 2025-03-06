import 'dart:convert';

import 'package:audition/core/data/app_exception.dart';
import 'package:audition/core/domain/providers/search_providers.dart';
import 'package:audition/core/network/apiclient.dart';
import 'package:audition/core/network/server_keys/apikeys.dart';
import 'package:audition/core/network/server_keys/endpoints.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/search/domain/model/search_result_response_model.dart';
import 'package:audition/features/search/domain/model/trending_response_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiServicesSearch {
  var client = ApiClient();
  Future<SearchData?> fetchSearchResult(
      String searchText, BuildContext context) async {
    var params = {Apikeys.search: searchText};
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.search);

    final response = await client.post(url, body: params);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      SearchResultResponseModel searchResultResponseModel =
          SearchResultResponseModel.fromJson(json);
      Provider.of<SearchProviders>(context, listen: false)
          .setSearchData(searchResultResponseModel.data!);
      return searchResultResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<List<TrendingResponse>?> getTrendingResult(
      BuildContext context) async {
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.trending);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      TrendingResultResponseModel trendingResultResponseModel =
          TrendingResultResponseModel.fromJson(json);
      return trendingResultResponseModel.data?.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<List<VideoResponse>?> fetchHashtagVideos(
      String hashtag, BuildContext context) async {
    var params = {Apikeys.id: hashtag};
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getHashTagVideo)
        .replace(queryParameters: params);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      try {
        AllVideoResponseModel videoResponseModel =
            AllVideoResponseModel.fromJson(json);
        return videoResponseModel.data;
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }
}
