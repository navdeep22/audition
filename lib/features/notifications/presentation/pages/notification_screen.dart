import 'package:audition/features/notifications/model/notification_response_model.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/profile/domain/profile_services.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future<List<NotificationModel>?>? allNotifications;
  ProfileServices profileServices = ProfileServices();
  @override
  void initState() {
    allNotifications = profileServices.fetchAllNotifications(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
        paddingOptional: true,
        title: AppString.notification,
        child: FutureBuilder(
            future: allNotifications,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const SizedBox.shrink();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    var allNotificationsList = snapshot.data;

                    return allNotificationsList!.isEmpty
                        ? Center(
                            child: Text(AppString.noDataFound,
                                style: CustomTextStyle.subTitleTextStyle()))
                        : ListView.builder(
                            itemCount: allNotificationsList.length,
                            itemBuilder: (context, index) => Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration:
                                    ContainerStyle.appGradientViewContainer(5),
                                child: Row(children: [
                                  const Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                  ),
                                  10.horizontalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allNotificationsList[index].title ?? "",
                                        style: CustomTextStyle.descTextStyle(),
                                      ),
                                      Text(
                                        AppFunctions.dateConverter(
                                            allNotificationsList[index]
                                                    .createdAt ??
                                                DateTime.now()),
                                        style: const TextStyle(
                                            color: Colors.amber, fontSize: 11),
                                      )
                                    ],
                                  )
                                ])));
                  }
              }
            }));
  }
}
