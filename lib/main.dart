import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testing/introScreen.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('Error: $e.code\nError Message: $e.message');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real - Time Eye Detection for Paralyzed Patients',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: cameras.isEmpty
          ? Center(
              child: Column(
                children: [
                  const Text(
                      "An error occurred while accessing camera, please grant the camera permission :)"),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextButton(
                        onPressed: () async {
                          Map<Permission, PermissionStatus> statuses =
                              await [Permission.camera].request();
                          debugPrint(statuses[Permission.camera].toString());
                          statuses[Permission.camera] == PermissionStatus.granted
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => IntroScreenPage(cameras: cameras)),
                                )
                              : const Text("");
                        },
                        child: const Text("Grant Permission!")),
                  ),
                ],
              ),
            )
          : IntroScreenPage(
              cameras: cameras,
            ),
    );
  }
}
