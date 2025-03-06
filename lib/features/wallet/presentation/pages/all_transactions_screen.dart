import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/profile/domain/profile_services.dart';
import 'package:audition/features/wallet/model/all_transactions_response_model.dart';
import 'package:audition/features/wallet/presentation/widget/transactions_list.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key});

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  Future<List<AllTransactionModel>?>? allTransactions;
  ProfileServices profileServices = ProfileServices();
  @override
  void initState() {
    allTransactions = profileServices.getAllTransactions(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
      paddingOptional: false,
      title: AppString.allTransactions,
      child: FutureBuilder(
          future: allTransactions,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const SizedBox.shrink();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  var transactionList = snapshot.data;

                  return transactionList!.isEmpty
                      ? Center(
                          child: Text(AppString.noDataFound,
                              style: CustomTextStyle.subTitleTextStyle()))
                      : TransactionsList(
                          transactionList: transactionList,
                          fromBlockUsers: true);
                }
            }
          }),
    );
  }
}
