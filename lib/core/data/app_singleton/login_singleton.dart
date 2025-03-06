class LoginSingleton {
  static final LoginSingleton _instance = LoginSingleton._internal();

  bool isGuestUser = true;
  LoginSingleton._internal();

  factory LoginSingleton() {
    return _instance;
  }

  void updateGuestUser(bool newValue) {
    isGuestUser = newValue;
  }
}

class AppGlobalSettings {
  static var homeApiCalled = false;
  static var searchApiCalled = false;
  static var challengeApiCalled = false;
}
