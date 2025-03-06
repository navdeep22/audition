import 'package:audition/features/search/domain/model/trending_response_model.dart';
import 'package:audition/features/search/domain/search_services.dart';
import 'package:audition/features/search/presentation/widget/trending_list.dart';
import 'package:flutter/material.dart';

class TrendingContent extends StatefulWidget {
  const TrendingContent({super.key});

  @override
  State<TrendingContent> createState() => _TrendingContentState();
}

class _TrendingContentState extends State<TrendingContent> {
  Future<List<TrendingResponse>?>? trendingResponse;
  SearchServices searchServices = SearchServices();

  @override
  void initState() {
    trendingResponse = searchServices.getTrendingResult(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: trendingResponse,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const SizedBox.shrink();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var videos = snapshot.data;

                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: videos?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TrendingList(trendingResponse: videos?[index]);
                    });
              }
          }
        });
  }
}
