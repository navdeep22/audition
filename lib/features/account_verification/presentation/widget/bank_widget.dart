import 'dart:io';

import 'package:audition/core/data/app_toast.dart';
import 'package:audition/features/account_verification/domain/account_verification_services.dart';
import 'package:audition/features/account_verification/model/all_verify_response_model.dart';
import 'package:audition/features/account_verification/model/bank_response_model.dart';
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

class BankWidget extends StatefulWidget {
  final AllVerifyModel? allVerifyModel;
  const BankWidget({super.key, required this.allVerifyModel});

  @override
  State<BankWidget> createState() => _BankWidgetState();
}

class _BankWidgetState extends State<BankWidget> {
  String pickedFileLink = "";
  AllVerifyModel? allVerifyModel;
  TextEditingController accountHolderNameEditingController =
      TextEditingController();
  TextEditingController accountNumberEditingController =
      TextEditingController();
  TextEditingController verifyAccountNumberEditingController =
      TextEditingController();
  TextEditingController bankNameEditingController = TextEditingController();
  TextEditingController branchNameEditingController = TextEditingController();
  TextEditingController ifscCodeEditingController = TextEditingController();
  TextEditingController stateEditingController = TextEditingController();
  String? stateController = "Select State";
  List<String> stateList = [
    "Select State",
    "Andaman and Nicobar Islands",
    "Arunachal Pradesh",
    "Bihar",
    "Chandigarh",
    "Chhattisgarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu &amp; Kashmir",
    "Jharkhand",
    "Kerala",
    "Lakshadweep",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Pondicherry",
    "Punjab",
    "Rajasthan",
    "Tamil Nadu",
    "Tripura",
    "Uttaranchal",
    "Uttar Pradesh",
    "West Benga'"
  ];
  AccountVerificationServices accountVerificationServices =
      AccountVerificationServices();
  Future<BankModel?>? bankDetails;
  @override
  void initState() {
    allVerifyModel = widget.allVerifyModel;
    bankDetails = accountVerificationServices.fetchBankdDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      10.verticalSpace,
      if (allVerifyModel?.panVerify == -1 || allVerifyModel?.panVerify == 2)
        panNotVerified(),
      if ((allVerifyModel?.panVerify == 1 || allVerifyModel?.panVerify == 0) &&
          allVerifyModel?.bankVerify == -1)
        bankNotVerified(),
      if (allVerifyModel?.bankVerify == 0) bankSentForVerification(),
      if (allVerifyModel?.bankVerify == 1) bankSentForVerification(),
      if (allVerifyModel?.panVerify == 2)
        Column(
          children: [
            bankSentForVerification(),
            10.verticalSpace,
            bankNotVerified(),
          ],
        )
    ]));
  }

  Widget panNotVerified() {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: ContainerStyle.appGradientViewContainer(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(AppString.verifyYourBankDetails,
              style: CustomTextStyle.subTitleTextStyle()),
          10.verticalSpace,
          Text(AppString.bankVerifySubtitle,
              style: CustomTextStyle.subTitleTextStyle()),
          10.verticalSpace,
          const Text(AppString.bankVerifyDescription,
              style: TextStyle(color: Colors.yellow, fontSize: 12)),
        ]));
  }

  Widget bankNotVerified() {
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
            title: AppString.uploadBankAccountProof,
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
                    controller: accountHolderNameEditingController,
                    hintText: AppString.accountHolderName)),
            10.verticalSpace,
            Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                decoration: ContainerStyle.cornerRadiusWithColor(
                    7, AppColors.primaryColor),
                height: 45,
                child: AppTextfield(
                    controller: accountNumberEditingController,
                    hintText: AppString.accountNumber)),
            10.verticalSpace,
            Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                decoration: ContainerStyle.cornerRadiusWithColor(
                    7, AppColors.primaryColor),
                height: 45,
                child: AppTextfield(
                    controller: verifyAccountNumberEditingController,
                    hintText: AppString.verifyAccountNumber)),
            10.verticalSpace,
            Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                decoration: ContainerStyle.cornerRadiusWithColor(
                    7, AppColors.primaryColor),
                height: 45,
                child: AppTextfield(
                    controller: bankNameEditingController,
                    hintText: AppString.bankName)),
            10.verticalSpace,
            Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                decoration: ContainerStyle.cornerRadiusWithColor(
                    7, AppColors.primaryColor),
                height: 45,
                child: AppTextfield(
                    controller: branchNameEditingController,
                    hintText: AppString.branchName)),
            10.verticalSpace,
            Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                decoration: ContainerStyle.cornerRadiusWithColor(
                    7, AppColors.primaryColor),
                height: 45,
                child: AppTextfield(
                    controller: ifscCodeEditingController,
                    hintText: AppString.ifscCode)),
            10.verticalSpace,
            const Text(AppString.selectState,
                style: TextStyle(color: Colors.yellow, fontSize: 12)),
            5.verticalSpace,
            Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              decoration: ContainerStyle.cornerRadiusWithColor(
                  7, AppColors.primaryColor),
              height: 45,
              child: DropdownButtonFormField<String>(
                style: CustomTextStyle.subTitleTextStyle(),
                hint: const Text(AppString.state,
                    style: TextStyle(
                      color: AppColors.appGreyColor,
                    )),
                value: stateController,
                dropdownColor: AppColors.primaryColor,
                onChanged: (String? newValue) {
                  setState(() {
                    stateController = newValue;
                  });
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                items: stateList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            30.verticalSpace,
          ],
        ),
        AppButton(
            title: AppString.submitForVerification,
            isDisable: false,
            onTap: () => upldateBankDetails()),
      ]),
    );
  }

  void upldateBankDetails() {
    FocusScope.of(context).unfocus();
    if (accountHolderNameEditingController.text.toString().length < 3) {
      appToast(msg: "Please enter account holder name");
    } else if (accountNumberEditingController.text.length < 6) {
      appToast(msg: "Please enter account number");
    } else if (branchNameEditingController.text.length < 2) {
      appToast(msg: "Please enter branch name");
    } else if (bankNameEditingController.text.length < 2) {
      appToast(msg: "Please enter bank name");
    } else if (verifyAccountNumberEditingController.text.length < 6) {
      appToast(msg: "Please enter verify account number");
    } else if (accountNumberEditingController.text !=
        verifyAccountNumberEditingController.text) {
      appToast(
          msg: "Your account number and verify account number not matched");
    } else if (ifscCodeEditingController.text.isEmpty) {
      appToast(msg: "Please enter valid IFSC Code");
    } else if (stateController == "Select State") {
      appToast(msg: "Please select your state");
    } else if (pickedFileLink == "") {
      appToast(msg: "Please click a image of passbook first");
    } else {
      AccountVerificationServices()
          .addBankDetailsForVerification(
              accountHolderNameEditingController.text,
              accountNumberEditingController.text,
              bankNameEditingController.text,
              branchNameEditingController.text,
              ifscCodeEditingController.text,
              stateController ?? "",
              File(pickedFileLink),
              context)
          .then((isUploaded) {
        if (isUploaded ?? false) {
          // panDetails = accountVerificationServices.fetchPanCardDetails(context);
          setState(() {
            allVerifyModel?.bankVerify = 0;
          });
        }
      });
    }
  }

  void pickedFile(String pickedFile) {
    if (pickedFile.isNotEmpty) {
      pickedFileLink = pickedFile;

      setState(() {});
    }
  }

  Widget bankSentForVerification() {
    return FutureBuilder(
        future: bankDetails,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const SizedBox.shrink();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var bankDetails = snapshot.data;
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
                              Text(AppString.verifyYourBankDetails,
                                  style: CustomTextStyle.subTitleTextStyle()),
                              Text(
                                  allVerifyModel?.panVerify == 2
                                      ? AppString.bankCardDetailsRejected
                                      : allVerifyModel?.panVerify == 1
                                          ? AppString.bankDetailsVerified
                                          : AppString.bankSentForVerification,
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
                                  const Text(AppString.accountHolderName,
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 15)),
                                  5.verticalSpace,
                                  const Text(AppString.accountNumber,
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 15)),
                                  5.verticalSpace,
                                  const Text(AppString.bankName,
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 15)),
                                  5.verticalSpace,
                                  const Text(AppString.branchName,
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 15)),
                                  5.verticalSpace,
                                  const Text(AppString.ifscCode,
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 15)),
                                  5.verticalSpace,
                                  const Text(AppString.state,
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
                                    Text(bankDetails?.accountholdername ?? "",
                                        style: CustomTextStyle
                                            .subTitleTextStyle()),
                                    5.verticalSpace,
                                    Text(bankDetails?.accno ?? "",
                                        style: CustomTextStyle
                                            .subTitleTextStyle()),
                                    5.verticalSpace,
                                    Text(bankDetails?.bankname ?? "",
                                        style: CustomTextStyle
                                            .subTitleTextStyle()),
                                    5.verticalSpace,
                                    Text(bankDetails?.bankbranch ?? "",
                                        style: CustomTextStyle
                                            .subTitleTextStyle()),
                                    5.verticalSpace,
                                    Text(bankDetails?.ifsc ?? "",
                                        style: CustomTextStyle
                                            .subTitleTextStyle()),
                                    5.verticalSpace,
                                    Text(bankDetails?.state ?? "",
                                        style: CustomTextStyle
                                            .subTitleTextStyle()),
                                    5.verticalSpace,
                                    if (allVerifyModel?.panVerify == 2)
                                      Text(bankDetails?.comment ?? "",
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
                                  imagePath: bankDetails?.image ?? ""),
                            ),
                          ),
                        ],
                      )),
                ]);
              }
          }
        });
  }
}
