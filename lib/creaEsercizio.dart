import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'bro.dart';
import 'main.dart';
import 'options.dart';
import 'profile.dart';
import 'schedeStruct.dart';
import 'viewGraph.dart';
import 'training.dart';
import 'creaScheda.dart';
import 'schede.dart';
import 'login.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CreaEsercizio extends StatefulWidget {
  const CreaEsercizio({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<CreaEsercizio> {
  final datasets = <String, dynamic>{};

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
                    Text('CREA ESERCIZIO',
                        style: GoogleFonts.adventPro(
                          textStyle: TextStyle(
                            color: const Color(0xFF000000),
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
                                builder: (context) => PageSchedePage(),
                              ),
                            );
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.height * 0.05,
                              height: MediaQuery.of(context).size.height * 0.13,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                  border: Border.all(color: Colors.black, width: 2)),
                              child: Icon(
                                Icons.arrow_back,
                                size: MediaQuery.of(context).size.height * 0.037,
                                color: Color(0xFF000000),
                              )),
                        ))
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.003,
                width: MediaQuery.of(context).size.height * 1,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.04,
                ),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                    border: Border.all(color: Colors.black, width: 1)),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 228, 229, 224),
        body: Container(
          child: new SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.03,
                    right: MediaQuery.of(context).size.height * 0.03,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      border: Border.all(color: Colors.transparent, width: 0)),
                  child: new SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                        ),
                        padding: EdgeInsets.zero,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(),
                        child: TextFormField(
                          cursorColor: Theme.of(context).cursorColor,
                          initialValue: '',
                          maxLength: 30,
                          decoration: InputDecoration(
                            labelText: 'Inserire Nome Esercizio',
                            labelStyle: TextStyle(
                              color: Color(0xFF6200EE),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6200EE)),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.03,
                    right: MediaQuery.of(context).size.height * 0.03,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      border: Border.all(color: Colors.transparent, width: 0)),
                  child: new SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                        ),
                        padding: EdgeInsets.zero,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(),
                        child: TextFormField(
                          cursorColor: Theme.of(context).cursorColor,
                          initialValue: '',
                          maxLength: 3,
                          decoration: InputDecoration(
                            labelText: 'Inserire Numero Ripetizioni',
                            labelStyle: TextStyle(
                              color: Color(0xFF6200EE),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6200EE)),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.03,
                    right: MediaQuery.of(context).size.height * 0.03,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      border: Border.all(color: Colors.transparent, width: 0)),
                  child: new SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                        ),
                        padding: EdgeInsets.zero,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(),
                        child: TextFormField(
                          cursorColor: Theme.of(context).cursorColor,
                          initialValue: '',
                          maxLength: 3,
                          decoration: InputDecoration(
                            labelText: 'Inserire Numero Serie',
                            labelStyle: TextStyle(
                              color: Color(0xFF6200EE),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6200EE)),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.03,
                    right: MediaQuery.of(context).size.height * 0.03,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      border: Border.all(color: Colors.transparent, width: 0)),
                  child: new SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                        ),
                        padding: EdgeInsets.zero,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(),
                        child: TextFormField(
                          cursorColor: Theme.of(context).cursorColor,
                          initialValue: '',
                          maxLength: 3,
                          decoration: InputDecoration(
                            labelText: 'Inserire Peso',
                            labelStyle: TextStyle(
                              color: Color(0xFF6200EE),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6200EE)),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.03,
                    right: MediaQuery.of(context).size.height * 0.03,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      border: Border.all(color: Colors.transparent, width: 0)),
                  child: new SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                        ),
                        padding: EdgeInsets.zero,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(),
                        child: TextFormField(
                          cursorColor: Theme.of(context).cursorColor,
                          initialValue: '',
                          decoration: InputDecoration(
                            labelText: 'Note',
                            labelStyle: TextStyle(
                              color: Color(0xFF6200EE),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6200EE)),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 50,
                    top: 10,
                    right: 50,
                  ),
                  padding: EdgeInsets.zero,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(),
                  child: GestureDetector(
                      onTap: () async {
                        await Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageSchedePage(),
                          ),
                        );
                      },
                      child: Container(
                          width: 10,
                          height: 40,
                          padding: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.05),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              border: Border.all(color: Colors.white)),
                          child: Text(
                            '''Registra Esercizio''',
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
                          ))),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.red.withOpacity(0.5),
          unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
          selectedFontSize: MediaQuery.of(context).size.height * 0.02,
          unselectedFontSize: MediaQuery.of(context).size.height * 0.02,
          onTap: (value) {
            setState(() => _currentIndex = value);
            if (value == 1)
              Navigator.push(context, MaterialPageRoute(builder: (context) => Training()));
            else if (value == 2) Navigator.push(context, MaterialPageRoute(builder: (context) => ViewGraph()));
          },
          items: [
            BottomNavigationBarItem(
              title: Text('Schede',
                  style: GoogleFonts.adventPro(
                      textStyle: TextStyle(
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ))),
              icon: Icon(Icons.article_outlined),
            ),
            BottomNavigationBarItem(
              title: Text('Allenamento',
                  style: GoogleFonts.adventPro(
                      textStyle: TextStyle(
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ))),
              icon: Icon(Icons.fitness_center_sharp),
            ),
            BottomNavigationBarItem(
              title: Text('Grafici',
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
