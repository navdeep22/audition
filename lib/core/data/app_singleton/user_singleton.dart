import 'package:audition/features/profile/model/user_full_details_model.dart';

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();

  factory UserSingleton() {
    return _instance;
  }
  UserData? userData;

  UserSingleton updateUserData(UserData? data) {
    userData = data;
    return this;
  }

  UserSingleton._internal();
}
