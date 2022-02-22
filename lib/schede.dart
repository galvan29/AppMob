import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'main.dart';

class PageSchedePage extends StatefulWidget {
  const PageSchedePage({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PageSchedePage> {
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
              margin: const EdgeInsets.only(
                top: 20,
              ),
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Color(0xFF000000),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(r'''SCHEDE''',
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 40,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1),
                  Icon(
                    MdiIcons.fromString('''account-box'''),
                    size: 50,
                    color: Color(0xFFFFFFFF),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
        backgroundColor: const Color.fromARGB(255, 34, 1, 48),
        body: Stack(),
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
              onTap: () async {
                await Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
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
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Ciao',
              style: GoogleFonts.adventPro(
                textStyle: TextStyle(
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                ))),
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            title: Text('Ciao',
                style: GoogleFonts.adventPro(
                    textStyle: TextStyle(
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ))),
            icon: Icon(Icons.music_note),
          ),
          BottomNavigationBarItem(
            title: Text('Ciao',
                style: GoogleFonts.adventPro(
                    textStyle: TextStyle(
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ))),
            icon: Icon(Icons.location_on),
          ),
        ],
      )
    );
  }
}
