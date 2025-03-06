import 'package:audition/features/home/domain/home_services.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/home/model/report_response_model.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/widgets/alerts/report_alert.dart';
import 'package:audition/widgets/pop_up_widget.dart';
import 'package:flutter/material.dart';

class FeedNotInterested extends StatefulWidget {
  final VideoResponse videoResponse;
  const FeedNotInterested({super.key, required this.videoResponse});

  @override
  State<FeedNotInterested> createState() => _FeedNotInterestedState();
}

class _FeedNotInterestedState extends State<FeedNotInterested> {
  Future<List<ReportModel>?>? notInterested;
  HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    notInterested = homeServices.fetchNotInterestedList(context);
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
        title: AppString.notInterested,
        child: FutureBuilder(
            future: notInterested,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const SizedBox.shrink();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    var reportList = snapshot.data;
                    return PageView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: reportList?.length ?? 0,
                        itemBuilder: (context, index) =>
                            feedReport(reportList!));
                  }
              }
            }));
  }

  Widget feedReport(List<ReportModel> model) {
    return ListView.builder(
        itemCount: model.length,
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                AppFunctions.showDialogueBox(
                  context,
                  ReportAlert(
                    title: AppString.notInterested,
                    subtitle: model[index].name ?? "",
                    onTap: (status) {
                      if (status) {
                        homeServices.notIntrestedVideo(
                            widget.videoResponse.id ?? "",
                            model[index].id ?? "",
                            context);
                      }
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(model[index].name ?? "",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15)),
                              const Spacer(),
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.black,
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            ));
  }
}
