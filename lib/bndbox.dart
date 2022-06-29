import 'package:flutter/material.dart';

class BndBox extends StatefulWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;

  const BndBox(
      this.results, this.previewH, this.previewW, this.screenH, this.screenW,
      {Key? key})
      : super(key: key);

  @override
  State<BndBox> createState() => _BndBoxState();
}

class _BndBoxState extends State<BndBox> {
  int check(List<String> gaugeResults) {
    int len = gaugeResults.length;
    if (len > 2) {
      for (int i = 2; i <= len + 1; i++) {
        if ((gaugeResults[i - 2] == "Left Eyes") &&
            (gaugeResults[i - 1] == "Closed Eyes") &&
            (gaugeResults[i] == "Right Eyes")) {
          return 1;
        }
      }
    }
    return 0;
  }

  // List<String> gaugedResults = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderStrings() {
      double offset = 60;
      bool emergency = false;
      return widget.results.map((re) {
        String label = re["label"];
        // gaugedResults.add(label);
        // debugPrint(label + gaugedResults.length.toString());
        // int j = check(gaugedResults);
        // if (j == 1) {
        //   setState(() {
        //     emergency = true;
        //   });
        //   showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return AlertDialog(
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(8)),
        //           title: Text(
        //             "Emergency Initiated",
        //             style: TextStyle(fontSize: 36),
        //           ),
        //           actions: <Widget>[
        //             TextButton(
        //                 onPressed: () {
        //                   Navigator.of(context).pop();
        //                 },
        //                 child: Text(
        //                   "Taken Care Of!",
        //                   style: TextStyle(color: Colors.black),
        //                 ))
        //           ],
        //         );
        //       });
        //   j = 0;
        //   gaugedResults.clear();
        // }
        double confidenceLevel = re["confidence"];
        offset = offset + 14;
        return Positioned(
          left: 20,
          top: offset,
          width: widget.screenW,
          height: widget.screenH,
          child: Text(
            "$label with ${(confidenceLevel * 100).toStringAsFixed(0)}%",
            style: const TextStyle(
              color: Color.fromRGBO(37, 213, 253, 1.0),
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList();
    }

    return Stack(children: _renderStrings());
  }
}
