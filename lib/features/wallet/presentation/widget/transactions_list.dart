import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/wallet/model/all_transactions_response_model.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final List<AllTransactionModel> transactionList;
  final bool fromBlockUsers;
  const TransactionsList(
      {super.key, required this.transactionList, required this.fromBlockUsers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: transactionList.length,
        itemBuilder: (context, index) {
          var transaction = transactionList[index];
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            decoration: ContainerStyle.appGradientViewContainer(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.type ?? "",
                    style: CustomTextStyle.descWithBolTextStyle()),
                Text("₹${transaction.amount}",
                    style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                5.verticalSpace,
                Text(
                    AppFunctions.dateConverter(
                        transaction.createdAt ?? DateTime.now()),
                    style: CustomTextStyle.descWithBolTextStyle()),
              ],
            ),
          );
        });
  }
}
