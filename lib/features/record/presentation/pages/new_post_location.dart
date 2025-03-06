import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/record/domain/record_services.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class NewPostLocation extends StatefulWidget {
  final Function(String) locationSelected;
  const NewPostLocation({super.key, required this.locationSelected});

  @override
  State<NewPostLocation> createState() => _NewPostLocationState();
}

class _NewPostLocationState extends State<NewPostLocation> {
  TextEditingController placeController = TextEditingController();
  List<dynamic> placeList = [];
  @override
  void initState() {
    super.initState();
    placeController.addListener(() {
      _onChanged();
    });
  }

  void _onChanged() async {
    await RecordServices.getLocationResults(placeController.text,
        (List<dynamic> updatedPlaceList) {
      setState(() {
        placeList = updatedPlaceList;
      });
    }, context);
  }

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
        paddingOptional: false,
        title: AppString.selectLocation,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            whereToGoField(),
            10.verticalSpace,
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: placeList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    widget.locationSelected(
                        placeList[index]['description'] ?? "");
                    Navigator.pop(context);
                  },
                  title: Text(
                    placeList[index]['description'] ?? "",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
            10.verticalSpace,
          ],
        ));
  }

  whereToGoField() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
          )),
      child: TextField(
        controller: placeController,
        cursorColor: Colors.white,
        style: CustomTextStyle.subTitleTextStyle(),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          counter: SizedBox.shrink(),
          border: InputBorder.none,
          hintText: AppString.searchLocation,
          labelStyle: TextStyle(fontSize: 12),
          hintStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
