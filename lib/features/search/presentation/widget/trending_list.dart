import 'package:audition/features/onboarding/presentation/widget/app_text.dart';
import 'package:audition/features/search/domain/model/trending_response_model.dart';
import 'package:flutter/material.dart';

class TrendingList extends StatelessWidget {
  final TrendingResponse? trendingResponse;
  const TrendingList({super.key, required this.trendingResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.abc),
              AppText(title: trendingResponse?.name ?? "")
            ],
          )
        ],
      ),
    );
  }
}
