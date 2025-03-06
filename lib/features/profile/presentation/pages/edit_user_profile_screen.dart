import 'dart:io';

import 'package:audition/core/data/app_singleton/user_singleton.dart';
import 'package:audition/features/onboarding/presentation/widget/app_button.dart';
import 'package:audition/features/onboarding/presentation/widget/app_textfield.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/profile/domain/profile_services.dart';
import 'package:audition/features/profile/model/user_full_details_model.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_picker/app_picker.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:audition/widgets/cache_images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditUserProfileScreen extends StatefulWidget {
  const EditUserProfileScreen({super.key});

  @override
  State<EditUserProfileScreen> createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _biggieIdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  String? _genderController;
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateNameController = TextEditingController();
  UserData? userData;
  String pickedFileLink = "";
  @override
  void initState() {
    userData = UserSingleton().userData;
    _nameController.text = userData?.name ?? "";
    _biggieIdController.text = userData?.auditionId ?? "";
    _phoneController.text = userData!.mobile.toString();
    _bioController.text = userData?.bio ?? "";
    _genderController = userData!.gender!.isEmpty ? null : userData!.gender;
    _dobController.text = userData?.dob ?? "";
    _cityController.text = userData?.city ?? "";
    _stateNameController.text = userData?.state ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
        paddingOptional: true,
        title: AppString.editProfile,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 70,
                height: 70,
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
                    : userData!.image!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: CacheImages(
                              imagePath: userData!.image!,
                            ),
                          )
                        : const Icon(
                            FontAwesomeIcons.solidCircleUser,
                            size: 60,
                            color: Colors.white,
                          ),
              ),
              10.verticalSpace,
              GestureDetector(
                onTap: () {
                  AppPicker.pickImage().then((value) => pickedFile(value));
                },
                child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(7)),
                    child: const Center(
                        child: Text(
                      AppString.changePhoto,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ))),
              ),
              20.verticalSpace,
              legends(
                  Icons.person,
                  AppTextfield(
                      controller: _nameController, hintText: AppString.name)),
              10.verticalSpace,
              legends(
                  FontAwesomeIcons.at,
                  AppTextfield(
                      isEnabled: false,
                      controller: _biggieIdController,
                      hintText: AppString.biggeeId)),
              10.verticalSpace,
              legends(
                  Icons.speaker_phone_sharp,
                  AppTextfield(
                      isEnabled: false,
                      controller: _phoneController,
                      hintText: AppString.mobileNumber)),
              10.verticalSpace,
              legends(
                  Icons.edit_calendar_rounded,
                  AppTextfield(
                      controller: _bioController, hintText: AppString.bio),
                  isBio: true),
              10.verticalSpace,
              legends(
                Icons.send_time_extension_rounded,
                DropdownButtonFormField<String>(
                  style: CustomTextStyle.subTitleTextStyle(),
                  value: _genderController,
                  dropdownColor: AppColors.primaryColor,
                  onChanged: (String? newValue) {
                    setState(() {
                      _genderController = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  items: <String>['Male', 'Female']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              10.verticalSpace,
              legends(
                  Icons.calendar_month,
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AppTextfield(
                        isEnabled: false,
                        controller: _dobController,
                        hintText: AppString.dob),
                  )),
              10.verticalSpace,
              legends(
                  Icons.location_city,
                  AppTextfield(
                      controller: _cityController, hintText: AppString.city)),
              10.verticalSpace,
              legends(
                  Icons.temple_buddhist,
                  AppTextfield(
                      controller: _stateNameController,
                      hintText: AppString.stateName)),
              20.verticalSpace,
              AppButton(
                  title: AppString.save,
                  isDisable: false,
                  onTap: () {
                    ProfileServices().editUserProfile(
                        _nameController.text,
                        _phoneController.text,
                        _bioController.text,
                        _genderController ?? "",
                        _dobController.text,
                        File(pickedFileLink),
                        context);
                  })
            ],
          ),
        ));
  }

  legends(IconData icon, Widget textController, {bool isBio = false}) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.appTextColor,
          size: 30,
        ),
        10.horizontalSpace,
        Expanded(
          child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              decoration: ContainerStyle.cornerRadiusWithColor(
                  7, AppColors.primaryColor),
              height: isBio ? 100 : 45,
              child: textController),
        )
      ],
    );
  }

  void pickedFile(String pickedFile) {
    if (pickedFile.isNotEmpty) {
      pickedFileLink = pickedFile;

      setState(() {});
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2101);

    // Show date picker and update the controller with the selected date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        _dobController.text =
            '${pickedDate.toLocal()}'.split(' ')[0]; // Format as needed
      });
    }
  }
}
