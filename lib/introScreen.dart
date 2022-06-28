import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:testing/home.dart';

class IntroScreenPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const IntroScreenPage({Key? key, required this.cameras}) : super(key: key);

  @override
  IntroScreenPageState createState() => IntroScreenPageState();
}

class IntroScreenPageState extends State<IntroScreenPage> {
  Widget _buildImage(String assetName) {
    return Image.asset(
      'assets/$assetName',
      width: 200,
      height: 200,
      fit: BoxFit.contain,
    );
  }

  var pageDecoration = const PageDecoration(
      bodyTextStyle: TextStyle(fontSize: 32),
      pageColor: Color.fromARGB(255, 232, 244, 255),
      imagePadding: EdgeInsets.zero,
      footerPadding: EdgeInsets.only(top: 130));

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: const Color.fromARGB(255, 232, 244, 255),
      pages: [
        PageViewModel(
          title: "",
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text("Book", style: TextStyle(fontSize: 32)),
              Text("Appointments with", style: TextStyle(fontSize: 32)),
              Text("Doctors", style: TextStyle(fontSize: 32)),
            ],
          ),
          image: _buildImage('0001.jpeg'),
          decoration: pageDecoration,
          footer: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 232, 244, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.85, 64),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black, width: 4),
                      borderRadius: BorderRadius.circular(5))),
              onPressed: () {
                introKey.currentState!.controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              },
              child: const Text(
                "NEXT",
                style: TextStyle(fontSize: 27, color: Colors.black),
              )),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("Get Estimated Time", style: TextStyle(fontSize: 32)),
                Text("of Appointment", style: TextStyle(fontSize: 32))
              ],
            ),
          ),
          image: _buildImage('0002.jpeg'),
          decoration: pageDecoration,
          footer: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 232, 244, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.85, 64),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black, width: 4),
                      borderRadius: BorderRadius.circular(5))),
              onPressed: () {
                introKey.currentState!.controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              },
              child: const Text(
                "NEXT",
                style: TextStyle(fontSize: 27, color: Colors.black),
              )),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("Keep track of your", style: TextStyle(fontSize: 32)),
                Text("Position in the Queue", style: TextStyle(fontSize: 32))
              ],
            ),
          ),
          image: _buildImage('0003.jpeg'),
          decoration: pageDecoration,
          footer: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.85, 64),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black, width: 4),
                      borderRadius: BorderRadius.circular(5))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(widget.cameras)),
                );
              },
              child: const Text(
                "GET STARTED",
                style: TextStyle(fontSize: 27, color: Colors.white),
              )),
        ),
      ],
      showSkipButton: false,
      skip: const Text('Skip'),
      showDoneButton: false,
      curve: Curves.fastLinearToSlowEaseIn,
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.transparent,
        activeColor: Colors.black,
        shape: CircleBorder(side: BorderSide(color: Colors.black)),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Color.fromARGB(255, 232, 244, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      isProgress: true,
      isProgressTap: true,
      showNextButton: false,
      dotsFlex: 100,
    );
  }
}
