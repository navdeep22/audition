import 'dart:io';

import 'package:audition/core/data/app_singleton/login_singleton.dart';
import 'package:audition/features/contests/challenges/presentation/pages/challenges_screen.dart';
import 'package:audition/features/home/presentation/home_screen.dart';
import 'package:audition/features/onboarding/domain/onboarding_services.dart';
import 'package:audition/features/profile/presentation/pages/my_profile.dart';
import 'package:audition/features/search/presentation/pages/search_screen.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_images.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;
  static const platform = MethodChannel('com.camerakit.flutter.sample.simple');
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    showContest ? const ChallengesScreen() : Container(),
    Container(),
    const MyProfile()
  ];

  void _onItemTapped(int index) {
    print(showContest);
    _selectedIndex = index;
    if (_selectedIndex == 3) {
      _openCameraKitLenses();
    } else if (_selectedIndex == 2 && !showContest) {
    } else if (_selectedIndex != 0 &&
        _selectedIndex != 1 &&
        LoginSingleton().isGuestUser) {
      AppNavigator.navigateToOnboardingScreen(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<void> _openCameraKitLenses() async {
    final result = await platform.invokeMethod('openCameraKitLenses');
    final String path = result['path'] as String;
    final String mimeType = result['mime_type'] as String;
    if (mimeType != 'video') {
      return;
    }

    AppNavigator.navigateToViewRecordedVideo(File(path), false, "", context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image(image: AssetImage(AppIcons.homeBNIcon), height: 25),
              label: '',
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage(AppIcons.searchBNIcon), height: 25),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage(AppIcons.videoBNIcon), height: 25),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage(AppIcons.profileBNIcon), height: 25),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pink,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.appBackgroundColor,
        elevation: 0,
        onTap: _onItemTapped,
      ),
    );
  }
}
