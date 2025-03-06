import 'package:audition/core/domain/app_providers.dart';
import 'package:audition/core/network/repository/socket_services.dart';
import 'package:audition/core/network/server_keys/endpoints.dart';
import 'package:audition/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:audition/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final socketManager = SocketManager();
  socketManager.initSocket(url: APIEndpoints.socketURL);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.getAllProviders(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              textTheme:
                  GoogleFonts.exo2TextTheme(Theme.of(context).textTheme)),
          builder: (context, mywidget) {
            mywidget = EasyLoading.init()(context, mywidget);
            mywidget = MediaQuery(
              data: MediaQuery.of(context).copyWith(),
              child: mywidget,
            );
            mywidget = MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1),
              ),
              child: mywidget,
            );
            return mywidget;
          },
          home: const SplashScreen()),
    );
  }
}
