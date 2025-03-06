import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  static const platform = MethodChannel('com.camerakit.flutter.sample.simple');

  final List<Widget> _children = [
    const Text("Click on shutter icon to launch Camera Kit"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _children,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCameraKitLenses,
        tooltip: 'Camera Kit',
        child: const Icon(Icons.camera),
      ),
    );
  }

  Future<void> _openCameraKitLenses() async {
    final result = await platform.invokeMethod('openCameraKitLenses');
    final String path = result['path'] as String;
    final String mimeType = result['mime_type'] as String;
    if (mimeType != 'video') {
      return;
    }
    // ignore: use_build_context_synchronously
    AppNavigator.navigateToViewRecordedVideo(File(path), false, "", context);
  }
}
