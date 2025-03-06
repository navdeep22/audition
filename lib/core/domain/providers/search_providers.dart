import 'package:audition/features/search/domain/model/search_result_response_model.dart';
import 'package:flutter/material.dart';

class SearchProviders extends ChangeNotifier {
  SearchData? _searchData;

  SearchData? get search => _searchData;

  setSearchData(SearchData searchData) {
    _searchData = searchData;
    notifyListeners();
  }

  updateSearchData(SearchData searchData) {
    searchData = searchData;
  }
}
