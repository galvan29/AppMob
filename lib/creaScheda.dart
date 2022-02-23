import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helloworld/schede.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'bro.dart';
import 'main.dart';
import 'profile.dart';
import 'schedeStruct.dart';
import 'training.dart';
import 'schede.dart';
import 'dart:math';

class CreaScheda extends StatefulWidget {
  const CreaScheda({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<CreaScheda> {
  final datasets = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
  }

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.04,
                  left: MediaQuery.of(context).size.height * 0.03,
                  right: MediaQuery.of(context).size.height * 0.03,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('CREATE CARDS',
                        style: GoogleFonts.adventPro(
                          textStyle: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery.of(context).size.height * 0.05,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 1),
                    Container(
                        padding: EdgeInsets.zero,
                        decoration: const BoxDecoration(),
                        child: GestureDetector(
                          onTap: () async {
                            await Navigator.push<void>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(),
                              ),
                            );
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                  border: Border.all(
                                      color: Colors.white, width: 2)),
                              child: Icon(
                                Icons.perm_identity_sharp,
                                size:
                                    MediaQuery.of(context).size.height * 0.037,
                                color: Color(0xFFFFFFFF),
                              )),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 34, 1, 48),
        body: Stack(children: [
          Container(
          //SchedeStruct a = new SchedeStruct(rng.nextInt(2), "fff", 120);
          ),
          Container(
              margin: const EdgeInsets.only(
                left: 50,
                top: 20,
                right: 50,
              ),
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(),
              child: GestureDetector(
                onTap: () {
                  SchedeStruct a = new SchedeStruct(1, "fff", 120);
                  PageSchedePage().aggiungi(a);
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageSchedePage(),
                    ),
                  );
                },
                child: Container(
                    width: double.maxFinite,
                    height: 40,
                    padding: EdgeInsets.only(top: 7),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        border:
                        Border.all(color: Colors.white, width: 2)),
                    child: Text(
                      '''Login''',
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    )),
              ))
        ]));
  }
}
