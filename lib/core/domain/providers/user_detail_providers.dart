import 'package:audition/features/profile/model/user_full_details_model.dart';
import 'package:flutter/material.dart';

class UserDetailProviders extends ChangeNotifier {
  UserData? _userDetails;

  UserData? get userDetails => _userDetails;

  setUserData(UserData userDetails) {
    _userDetails = userDetails;
    notifyListeners();
  }

  updateUserData(UserData userDetails) {
    _userDetails = userDetails;
    notifyListeners();
  }
}
