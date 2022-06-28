import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:testing/main.dart';
import 'package:tflite/tflite.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

import 'camera.dart';
import 'bndbox.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const HomePage(this.cameras, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  bool granted = false;

  @override
  void initState() {
    super.initState();
    permission();
    loadModel();
  }

  permission() async {
    if (granted == false) {
      final status = await Permission.camera.request();
      if (status == PermissionStatus.granted) {
        setState(() {
          granted = true;
        });
      }
    }
  }

  loadModel() async {
    String? res = await Tflite.loadModel(
        model: "assets/vgg_model.tflite", labels: "assets/labels.txt");
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: granted == true
              ? Stack(
                  children: [
                    Camera(widget.cameras, setRecognitions),
                    BndBox(
                        _recognitions == null ? [] : _recognitions!,
                        math.max(_imageHeight, _imageWidth),
                        math.min(_imageHeight, _imageWidth),
                        screenSize.height,
                        screenSize.width),
                  ],
                )
              : SizedBox(
                  height: double.infinity,
                  child: Center(
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
                                debugPrint(
                                    statuses[Permission.camera].toString());
                                // statuses[Permission.camera] == PermissionStatus.granted
                                //     ? Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) => IntroScreenPage(cameras: cameras)),
                                //       )
                                //     : const Text("");
                              },
                              child: const Text("Grant Permission!")),
                        ),
                        const Text(
                            "You may have to manually go to settings and enable permission if this button doesn't work!"),
                      ],
                    ),
                  ),
                )),
    );
  }
}
