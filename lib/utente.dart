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
import 'package:dropdown_button2/dropdown_button2.dart';

class PageUtentePage extends StatefulWidget {
  const PageUtentePage({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PageUtentePage> {
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
                    Text('UTENTE',
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
                                  border: Border.all(color: Colors.black, width: 2)),
                              child: Icon(
                                Icons.star,
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
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.48,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  initialValue: 'Input text',
                  maxLength: 20,
                  decoration: InputDecoration(
                    icon: Icon(Icons.favorite),
                    labelText: 'Label text',
                    labelStyle: TextStyle(
                      color: Color(0xFF6200EE),
                    ),
                    helperText: 'Helper text',
                    suffixIcon: Icon(
                      Icons.check_circle,
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
