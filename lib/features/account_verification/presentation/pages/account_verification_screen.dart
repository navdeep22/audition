import 'package:audition/features/account_verification/domain/account_verification_services.dart';
import 'package:audition/features/account_verification/model/all_verify_response_model.dart';
import 'package:audition/features/account_verification/presentation/widget/bank_widget.dart';
import 'package:audition/features/account_verification/presentation/widget/mobile_and_email_widget.dart';
import 'package:audition/features/account_verification/presentation/widget/pancard_widget.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class AccountVerificationScreen extends StatefulWidget {
  const AccountVerificationScreen({super.key});

  @override
  State<AccountVerificationScreen> createState() =>
      _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  AccountVerificationServices accountVerificationServices =
      AccountVerificationServices();
  Future<AllVerifyModel?>? allVerify;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    allVerify = accountVerificationServices.allVerify(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
        paddingOptional: false,
        title: AppString.verifyAccount,
        child: Column(children: [
          TabBar(
            controller: tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[300],
            indicatorColor: Colors.white,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: AppString.mobileEmail),
              Tab(text: AppString.panCard),
              Tab(text: AppString.bank),
            ],
          ),
          10.verticalSpace,
          Expanded(
              child: FutureBuilder(
                  future: allVerify,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const SizedBox.shrink();
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          var allVerifyData = snapshot.data;
                          return TabBarView(
                            controller: tabController,
                            children: [
                              MobileAndEmailWidget(
                                  allVerifyModel: allVerifyData),
                              PancardWidget(allVerifyModel: allVerifyData),
                              BankWidget(allVerifyModel: allVerifyData)
                            ],
                          );
                        }
                    }
                  }))
        ]));
  }
}
