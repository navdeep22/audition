import 'package:audition/core/data/app_singleton/user_singleton.dart';
import 'package:audition/core/data/app_toast.dart';
import 'package:audition/features/onboarding/presentation/widget/app_green_button.dart';
import 'package:audition/features/onboarding/presentation/widget/app_phone_textfield.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/profile/domain/profile_services.dart';
import 'package:audition/features/profile/model/user_full_details_model.dart';
import 'package:audition/features/wallet/model/request_add_cash_response_model.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AddCashScreen extends StatefulWidget {
  final UserData userData;
  const AddCashScreen({super.key, required this.userData});

  @override
  State<AddCashScreen> createState() => _AddCashScreenState();
}

class _AddCashScreenState extends State<AddCashScreen> {
  TextEditingController amountEditingController =
      TextEditingController(text: "0");
  late Razorpay razorpay;
  int amount = 0;
  ProfileServices profileServices = ProfileServices();

  @override
  void initState() {
    razorpay = Razorpay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
        paddingOptional: true,
        title: AppString.addCash,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          10.verticalSpace,
          const Text(
            AppString.addCash,
            style: TextStyle(color: AppColors.appTextColor, fontSize: 18),
          ),
          10.verticalSpace,
          const Text(AppString.enterAmount,
              style: TextStyle(color: Colors.yellow, fontSize: 12)),
          Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              decoration: ContainerStyle.cornerRadiusWithColor(
                  7, AppColors.primaryColor),
              height: 45,
              child: AppPhoneTextfield(
                  controller: amountEditingController,
                  hintText: AppString.enterAmount)),
          10.verticalSpace,
          const Text(AppString.chooseAmount,
              style: TextStyle(color: Colors.yellow, fontSize: 12)),
          10.verticalSpace,
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    amount = int.parse(amountEditingController.text);
                    amount = amount + 100;
                    amountEditingController.text = amount.toString();
                  },
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white)),
                      child: const Center(
                          child: Text("+100",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15)))),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    amount = int.parse(amountEditingController.text);
                    amount = amount + 200;
                    amountEditingController.text = amount.toString();
                  },
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white)),
                      child: const Center(
                          child: Text("+200",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15)))),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    amount = int.parse(amountEditingController.text);
                    amount = amount + 500;
                    amountEditingController.text = amount.toString();
                  },
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white)),
                      child: const Center(
                          child: Text("+500",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15)))),
                ),
              )
            ],
          ),
          20.verticalSpace,
          AppGreenButton(
              title: AppString.addCash,
              isDisable: false,
              onTap: () {
                amount = int.parse(amountEditingController.text);
                if (amount < 10) {
                  appToast(msg: "Amount should be greater than ₹10");
                  return;
                }
                FocusScope.of(context).unfocus();
                if ((widget.userData.verified ?? 0) == 0) {
                  AppNavigator.navigateToVerifyAccountScreen(context);
                } else {
                  profileServices
                      .requestAddCash(amount.toString(), context)
                      .then((requestAddCash) {
                    openRazorPay(requestAddCash ?? RequestAddCashModel());
                  });
                }
              })
        ]));
  }

  void openRazorPay(RequestAddCashModel requestAddCash) {
    Razorpay razorpay = Razorpay();
    var options = {
      'name': "Biggee",
      'description': 'Payment for Order id: ${requestAddCash.orderid}',
      'key': 'rzp_live_O132Kc36sIYE3I',
      "currency": "INR",
      'payment_capture': true,
      'amount': amount * 100,
      'prefill': {
        'contact': UserSingleton().userData?.mobile ?? "",
        'email': UserSingleton().userData?.email ?? ""
      },
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    appToast(msg: "Payment failed: ${response.message}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    appToast(msg: "Payment successful");
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {}
}
