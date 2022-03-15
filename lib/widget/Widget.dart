import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:mytraining/db/eventiDBworrker.dart';
import 'package:mytraining/models/eventiModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/base.dart';
import 'package:mytraining/screen/login.dart';

class WidgetClass extends StatefulWidget {
  const WidgetClass({Key? key}) : super(key: key);

  @override
  State<WidgetClass> createState() => _Generated3WidgetState();
}

class _Generated3WidgetState extends State<WidgetClass>
    with TickerProviderStateMixin {
  late GifController controller;

  @override
  void initState() {
    controller = GifController(vsync: this);
    //fetchGif(AssetImage("assets/image/9b61a1215a12665056f1ac4fc2b110319a660ef2.gif"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
          height: 2400.0,
          child: Stack(children: [
            Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
              ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Container(
                  color: Colors.black,
                ),
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width * 0.37,
                  top: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.height * 0.10,
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: functionGif()),
            ])
          ])),
    );
  }

  functionGif() {
    print(controller.value);
    LoginPage().getValueLogin().then((val) async {
      await eventiModel.loadData(
          EventiDBworker.eventiDBworker, val);
    });
    if (utentiModel.stackIndex == 7) {
      controller.animateTo(111, duration: Duration(milliseconds: 2000));

      Timer(
          Duration(milliseconds: 2000),
          () => {
                utentiModel.setStackIndex(Base.pageIndexForWidget),
                controller.reset()
              });
    }
    return GifImage(
      controller: controller,
      image: const AssetImage(
          "assets/image/9b61a1215a12665056f1ac4fc2b110319a660ef2.gif"),
    );
  }
}
