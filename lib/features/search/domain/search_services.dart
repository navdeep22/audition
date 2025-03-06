import 'package:audition/core/network/repository/api_services/api_services_search.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/search/domain/model/search_result_response_model.dart';
import 'package:audition/features/search/domain/model/trending_response_model.dart';
import 'package:flutter/material.dart';

class SearchServices {
  ApiServicesSearch searchServices = ApiServicesSearch();

  Future<SearchData?> fetchSearchResult(
      String searchText, BuildContext context) {
    return searchServices.fetchSearchResult(searchText, context);
  }

  Future<List<TrendingResponse>?> getTrendingResult(BuildContext context) {
    return searchServices.getTrendingResult(context);
  }

  Future<List<VideoResponse>?> fetchHashtagVideos(
      String hashtag, BuildContext context) {
    return searchServices.fetchHashtagVideos(hashtag, context);
  }
}
