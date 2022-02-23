import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helloworld/sqlite_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'bro.dart';
import 'main.dart';
import 'profile.dart';
import 'viewGraph.dart';
import 'training.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class PageSchedePage extends StatefulWidget {
  const PageSchedePage({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PageSchedePage> {
  final datasets = <String, dynamic>{};

  late List<SchedeStruct> _schede;

  @override
  void initState() {
    super.initState();
  }

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
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
                    Text('CARDS',
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
        body: Container(
          child: Column(
            children: [
              for ( var scheda in _schede) Text("1")
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          openCloseDial: isDialOpen,
          backgroundColor: Colors.transparent,
          overlayOpacity: 0,
          spacing: 15,
          spaceBetweenChildren: 15,
          closeManually: true,
          children: [
            SpeedDialChild(
              child: Icon(Icons.construction),
              label: 'Modifica',
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Bro()));
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.remove),
              label: 'Elimina',
              onTap: () async {
                await Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.add),
              label: 'Aggiungi',
              onTap: () {
                SchedeStruct element=new SchedeStruct(4, "CiaoBro");
                _schede.add(element);
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
          selectedFontSize: MediaQuery.of(context).size.height * 0.02,
          unselectedFontSize: MediaQuery.of(context).size.height * 0.02,
          onTap: (value) {
            setState(() => _currentIndex = value);
            if (value == 1)
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Training()));
            else if (value == 2)
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewGraph()));
          },
          items: [
            BottomNavigationBarItem(
              title: Text('Cards',
                  style: GoogleFonts.adventPro(
                      textStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                  ))),
              icon: Icon(Icons.article_outlined),
            ),
            BottomNavigationBarItem(
              title: Text('Training',
                  style: GoogleFonts.adventPro(
                      textStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                  ))),
              icon: Icon(Icons.fitness_center_sharp),
            ),
            BottomNavigationBarItem(
              title: Text('Graph',
                  style: GoogleFonts.adventPro(
                      textStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                  ))),
              icon: Icon(Icons.bar_chart),
            ),
          ],
        ));
  }
}

class SchedeStruct{
  late final int id;
  late final String description;
  SchedeStruct(int a, String b){
    id=a;
    description=b;
  }
}