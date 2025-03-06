import 'package:audition/features/onboarding/presentation/widget/app_green_button.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/profile/domain/profile_services.dart';
import 'package:audition/features/profile/model/user_full_details_model.dart';
import 'package:audition/resources/app_constants/app_images.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:audition/widgets/cache_images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  Future<UserData?>? userData;
  ProfileServices profileServices = ProfileServices();

  @override
  void initState() {
    userData = profileServices.getUserProfile(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
        paddingOptional: true,
        title: AppString.wallet,
        child: FutureBuilder(
            future: userData,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const SizedBox.shrink();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    var userData = snapshot.data;

                    return userData == null
                        ? Center(
                            child: Text(AppString.noDataFound,
                                style: CustomTextStyle.subTitleTextStyle()))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                    borderRadius: BorderRadius.circular(40)),
                                child: (userData.image != "")
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(35),
                                        child: CacheImages(
                                          imagePath: userData.image ?? "",
                                        ),
                                      )
                                    : const Icon(
                                        FontAwesomeIcons.solidCircleUser,
                                        size: 70,
                                        color: Colors.white,
                                      ),
                              ),
                              10.verticalSpace,
                              Text(userData.auditionId ?? "",
                                  style: CustomTextStyle.subTitleTextStyle()),
                              50.verticalSpace,
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: ContainerStyle
                                          .appGradientViewContainer(5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("₹${userData.totalbalance}",
                                              style: CustomTextStyle
                                                  .headerTextStyle()),
                                          Text(AppString.deposit,
                                              style: CustomTextStyle
                                                  .subTitleTextStyle()),
                                        ],
                                      ),
                                    ),
                                  ),
                                  20.horizontalSpace,
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: ContainerStyle
                                          .appGradientViewContainer(5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("₹${userData.totalwon}",
                                              style: CustomTextStyle
                                                  .headerTextStyle()),
                                          Text(AppString.winings,
                                              style: CustomTextStyle
                                                  .subTitleTextStyle()),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: AppGreenButton(
                                          title: AppString.addCash,
                                          isDisable: false,
                                          onTap: () {
                                            AppNavigator
                                                .navigateToAddCashScreen(
                                                    userData, context);
                                          })),
                                  20.horizontalSpace,
                                  Expanded(
                                      child: AppGreenButton(
                                          title: AppString.withdraw,
                                          isDisable: true,
                                          onTap: () {}))
                                ],
                              ),
                              15.verticalSpace,
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration:
                                    ContainerStyle.appGradientViewContainer(5),
                                child: Row(
                                  children: [
                                    const Image(
                                      image: AssetImage(AppImages.cashBonus),
                                      height: 50,
                                      width: 50,
                                    ),
                                    10.horizontalSpace,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(AppString.cashBonus,
                                            style: CustomTextStyle
                                                .subTitleTextStyle()),
                                        Text("₹${userData.totalbonus}",
                                            style: CustomTextStyle
                                                .headerTextStyle()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AppNavigator.navigateToAllTransactionsScreen(
                                      context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration:
                                      ContainerStyle.appGradientViewContainer(
                                          5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Image(
                                        image:
                                            AssetImage(AppImages.transaction),
                                        height: 50,
                                        width: 50,
                                      ),
                                      10.horizontalSpace,
                                      Text(AppString.transactionReport,
                                          style: CustomTextStyle
                                              .subTitleTextStyle()),
                                      const Spacer(),
                                      const Icon(Icons.chevron_right,
                                          color: Colors.white)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                  }
              }
            }));
  }
}
