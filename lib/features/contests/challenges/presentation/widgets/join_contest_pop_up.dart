import 'package:audition/features/contests/challenges/domain/challenge_services.dart';
import 'package:audition/features/contests/challenges/domain/model/challenge_response_model.dart';
import 'package:audition/features/contests/challenges/domain/model/get_usable_balance_response_model.dart';
import 'package:audition/features/onboarding/presentation/widget/app_green_button.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class JoinContestPopUp extends StatefulWidget {
  final ChallengesModel challengesModel;
  final Function(GetUsableBalanceResponse) onJoinChallenge;
  const JoinContestPopUp(
      {super.key,
      required this.challengesModel,
      required this.onJoinChallenge});

  @override
  State<JoinContestPopUp> createState() => _JoinContestPopUpState();
}

class _JoinContestPopUpState extends State<JoinContestPopUp> {
  Future<GetUsableBalanceResponse?>? getUsableBalance;
  ChallengeServices challengeServices = ChallengeServices();
  @override
  void initState() {
    getUsableBalance = challengeServices.getUsableBalance(
        widget.challengesModel.id ?? "", context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUsableBalance,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const SizedBox.shrink();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var usableBalance = snapshot.data;

                return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Text("JOIN CONTEST",
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Available balance:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                            Text("₹${usableBalance?.usertotalbalance}",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15))
                          ],
                        ),
                        15.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Usable amount:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                            Text("₹${usableBalance?.usablebalance}",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15))
                          ],
                        ),
                        15.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Joining balance:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                            Text("₹${usableBalance?.entryfee}",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15))
                          ],
                        ),
                        18.verticalSpace,
                        const Text(
                            "Join amount will be deducted after uploading video successfully",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                        15.verticalSpace,
                        AppGreenButton(
                            title: "Join Contest",
                            isDisable: false,
                            onTap: () {
                              widget.onJoinChallenge(usableBalance!);
                            })
                      ],
                    ));
              }
          }
        });
  }
}
