import 'package:audition/features/contests/challenges/domain/model/contest_detail_response_model.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:flutter/material.dart';

class PrizeCardListview extends StatelessWidget {
  final ContestDetailModel challengesModel;
  const PrizeCardListview({super.key, required this.challengesModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: challengesModel.priceCard?.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: ContainerStyle.appGradientViewContainer(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Rank ${challengesModel.priceCard?[index].startPosition}",
                      style: CustomTextStyle.subTitleTextStyle()),
                  Text(
                      "${AppString.ruppeSymbol}${challengesModel.priceCard?[index].price}",
                      style: CustomTextStyle.subTitleTextStyle())
                ]),
          );
        });
  }
}
