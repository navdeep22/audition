import 'dart:io';

import 'package:audition/core/data/app_toast.dart';
import 'package:audition/features/account_verification/domain/account_verification_services.dart';
import 'package:audition/features/account_verification/model/all_verify_response_model.dart';
import 'package:audition/features/account_verification/model/pan_card_response_model.dart';
import 'package:audition/features/onboarding/presentation/widget/app_button.dart';
import 'package:audition/features/onboarding/presentation/widget/app_textfield.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_picker/app_picker.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/cache_images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PancardWidget extends StatefulWidget {
  final AllVerifyModel? allVerifyModel;
  const PancardWidget({super.key, required this.allVerifyModel});

  @override
  State<PancardWidget> createState() => _PancardWidgetState();
}

class _PancardWidgetState extends State<PancardWidget> {
  TextEditingController panNamelEditingController = TextEditingController();
  TextEditingController panNumberEditingController = TextEditingController();
  TextEditingController dobEditingController = TextEditingController();
  String pickedFileLink = "";
  AllVerifyModel? allVerifyModel;
  AccountVerificationServices accountVerificationServices =
      AccountVerificationServices();
  Future<PanCardModel?>? panDetails;
  @override
  void initState() {
    allVerifyModel = widget.allVerifyModel;
    panDetails = accountVerificationServices.fetchPanCardDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        10.verticalSpace,
        if (allVerifyModel?.emailVerify == 0 && allVerifyModel?.panVerify == -1)
          emailNotVerified(),
        if (allVerifyModel?.emailVerify == 1 && allVerifyModel?.panVerify == -1)
          panNotVerified(),
        if (allVerifyModel?.panVerify == 0) panSentForVerification(),
        if (allVerifyModel?.panVerify == 1) panSentForVerification(),
        if (allVerifyModel?.panVerify == 2)
          Column(
            children: [
              panSentForVerification(),
              10.verticalSpace,
              panNotVerified(),
            ],
          )
      ]),
    );
  }

  Widget emailNotVerified() {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: ContainerStyle.appGradientViewContainer(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(AppString.verifyYourPanDetails,
              style: CustomTextStyle.subTitleTextStyle()),
          10.verticalSpace,
          Text(AppString.panVerifySubtitle,
              style: CustomTextStyle.subTitleTextStyle()),
          10.verticalSpace,
          const Text(AppString.panVerifyDescription,
              style: TextStyle(color: Colors.yellow, fontSize: 12)),
        ]));
  }

  Widget panNotVerified() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Column(children: [
        Container(
          width: 110,
          height: 110,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.white),
              borderRadius: BorderRadius.circular(35)),
          child: pickedFileLink.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.file(
                    File(pickedFileLink),
                    fit: BoxFit.fill,
                  ))
              : const Icon(
                  FontAwesomeIcons.camera,
                  size: 60,
                  color: Colors.white,
                ),
        ),
        20.verticalSpace,
        AppButton(
            title: AppString.uploadPanImage,
            isDisable: false,
            onTap: () {
              FocusScope.of(context).unfocus();
              AppPicker.pickImage().then((value) => pickedFile(value));
            }),
        const Text(AppString.panImageSize,
            style: TextStyle(color: Colors.yellow, fontSize: 12)),
        30.verticalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                decoration: ContainerStyle.cornerRadiusWithColor(
                    7, AppColors.primaryColor),
                height: 45,
                child: AppTextfield(
                    controller: panNamelEditingController,
                    hintText: AppString.name)),
            const Text(AppString.panNumber,
                style: TextStyle(color: Colors.yellow, fontSize: 12)),
            10.verticalSpace,
            Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                decoration: ContainerStyle.cornerRadiusWithColor(
                    7, AppColors.primaryColor),
                height: 45,
                child: AppTextfield(
                    controller: panNumberEditingController,
                    hintText: AppString.panNumber)),
            const Text(AppString.panNumberValidation,
                style: TextStyle(color: Colors.yellow, fontSize: 12)),
            10.verticalSpace,
            GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    decoration: ContainerStyle.cornerRadiusWithColor(
                        7, AppColors.primaryColor),
                    height: 45,
                    child: AppTextfield(
                        isEnabled: false,
                        controller: dobEditingController,
                        hintText: AppString.dob))),
            30.verticalSpace,
          ],
        ),
        AppButton(
            title: AppString.submitForVerification,
            isDisable: false,
            onTap: () => uploadPanDetails()),
      ]),
    );
  }

  void uploadPanDetails() {
    FocusScope.of(context).unfocus();
    if (panNamelEditingController.text.isEmpty) {
      appToast(msg: "Please Enter Name");
    } else if (panNamelEditingController.text.toString().length < 4) {
      appToast(msg: "Enter name mor then 4 char");
    } else if (dobEditingController.text.isEmpty) {
      appToast(msg: "Please select dob");
    } else if (panNumberEditingController.text.isEmpty) {
      appToast(msg: "Please enter PAN number");
    } else if (pickedFileLink == "") {
      appToast(msg: "Please select image");
    } else {
      AccountVerificationServices()
          .addPanDetailsForVerification(
              panNamelEditingController.text,
              panNumberEditingController.text,
              dobEditingController.text,
              File(pickedFileLink),
              context)
          .then((isUploaded) {
        if (isUploaded ?? false) {
          panDetails = accountVerificationServices.fetchPanCardDetails(context);
          setState(() {
            allVerifyModel?.panVerify = 0;
          });
        }
      });
    }
  }

  Widget panSentForVerification() {
    return FutureBuilder(
        future: panDetails,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const SizedBox.shrink();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var panDetails = snapshot.data;
                return Column(children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      decoration: ContainerStyle.appGradientViewContainer(10),
                      child: Row(children: [
                        const Icon(Icons.credit_card,
                            color: Colors.white, size: 28),
                        10.horizontalSpace,
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppString.verifyYourPanDetails,
                                  style: CustomTextStyle.subTitleTextStyle()),
                              Text(
                                  allVerifyModel?.panVerify == 2
                                      ? AppString.panCardDetailsRejected
                                      : allVerifyModel?.panVerify == 1
                                          ? AppString.panCardVerified
                                          : AppString.panSentForVerification,
                                  style: const TextStyle(
                                      color: Colors.yellow, fontSize: 15))
                            ])
                      ])),
                  Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      decoration: ContainerStyle.appGradientViewContainer(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppString.panCard,
                              style: CustomTextStyle.subTitleTextStyle()),
                          5.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(AppString.name,
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 15)),
                                  5.verticalSpace,
                                  const Text(AppString.panNumber,
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 15)),
                                  5.verticalSpace,
                                  const Text(AppString.dob,
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 15)),
                                  5.verticalSpace,
                                  if (allVerifyModel?.panVerify == 2)
                                    const Text(AppString.comment,
                                        style: TextStyle(
                                            color: Colors.yellow,
                                            fontSize: 15)),
                                ],
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(panDetails?.panname ?? "",
                                        style: CustomTextStyle
                                            .subTitleTextStyle()),
                                    5.verticalSpace,
                                    Text(panDetails?.pannumber ?? "",
                                        style: CustomTextStyle
                                            .subTitleTextStyle()),
                                    5.verticalSpace,
                                    Text(panDetails?.pandob ?? "",
                                        style: CustomTextStyle
                                            .subTitleTextStyle()),
                                    5.verticalSpace,
                                    if (allVerifyModel?.panVerify == 2)
                                      Text(panDetails?.comment ?? "",
                                          style: CustomTextStyle
                                              .subTitleTextStyle()),
                                    5.verticalSpace,
                                  ]),
                              10.horizontalSpace
                            ],
                          ),
                          10.verticalSpace,
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 120,
                              height: 150,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(35)),
                              child: CacheImages(
                                  imagePath: panDetails?.image ?? ""),
                            ),
                          ),
                        ],
                      )),
                ]);
              }
          }
        });
  }

  Widget panVerified() {
    return const SizedBox.shrink();
  }

  void pickedFile(String pickedFile) {
    if (pickedFile.isNotEmpty) {
      pickedFileLink = pickedFile;

      setState(() {});
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2101);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        dobEditingController.text = '${pickedDate.toLocal()}'.split(' ')[0];
        FocusScope.of(context).unfocus();
      });
    }
  }
}
