import 'package:audition/features/onboarding/presentation/widget/parent_widget.dart';
import 'package:audition/features/search/domain/model/search_result_response_model.dart';
import 'package:audition/features/search/domain/search_services.dart';
import 'package:audition/features/search/presentation/widget/search_bar.dart';
import 'package:audition/features/search/presentation/widget/search_carousal.dart';
import 'package:audition/features/search/presentation/widget/searched_hashtag.dart';
import 'package:audition/features/search/presentation/widget/searched_users.dart';
import 'package:audition/features/search/presentation/widget/trending_reels.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<SearchData?>? trendingResponse;
  SearchServices searchServices = SearchServices();
  var searchString = "";

  @override
  void initState() {
    trendingResponse = searchServices.fetchSearchResult("", context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
        paddingOptional: false,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              SearchField(
                controller: TextEditingController(text: searchString),
                searchReels: (newSearchString) {
                  searchString = newSearchString;
                  trendingResponse =
                      searchServices.fetchSearchResult(searchString, context);
                  setState(() {});
                },
                clearData: () {
                  searchString = "";
                  setState(() {});
                },
              ),
              15.verticalSpace,
              const SearchCarousal(),
              15.verticalSpace,
              Expanded(
                  child: FutureBuilder(
                      future: trendingResponse,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const SizedBox.shrink();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              var videos = snapshot.data?.data;
                              var hashtag = snapshot.data?.hashtags;
                              var users = snapshot.data?.users;
                              if (searchString == "") {
                                users = [];
                                hashtag = [];
                              }
                              return ListView(
                                children: [
                                  SearchedUsers(userList: users),
                                  SearchedHashtags(hashtagsList: hashtag),
                                  TrendingReels(videos: videos)
                                ],
                              );
                            }
                        }
                      }))
            ],
          ),
        ));
  }
}
