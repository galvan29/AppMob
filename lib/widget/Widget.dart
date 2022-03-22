import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/eventiDBworrker.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:mytraining/models/eventiModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/base.dart';
import 'package:mytraining/screen/login.dart';
import 'package:mytraining/screen/schede.dart';

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
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
              ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Container(
                  color: Colors.black,
                ),
              ),
              Positioned(
                  width: MediaQuery.of(context).size.height * 0.15,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: functionGif()),
            ])
          ])),
    );
  }

  functionGif() {
    if (utentiModel.stackIndex == 7) {
      controller.animateTo(29, duration: const Duration(milliseconds: 1000));
      LoginPage().getValueLogin().then((val) async {
        await eventiModel.loadData(EventiDBworker.eventiDBworker, val);
      });

      print("SECONDO TIMER");
      Timer(
          const Duration(milliseconds: 1000),
          () => {
                utentiModel.setStackIndex(Base.pageIndexForWidget),
                controller.reset()
              });
    }
    return GifImage(
      controller: controller,
      image: const AssetImage(
          "assets/image/we.gif"),
    );
  }
}
