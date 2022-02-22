import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'main.dart';

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

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
            Container(
              margin: const EdgeInsets.only(
                top: 15,
              ),
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Color(0xFF000000),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () async {
                        await Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ),
                        );
                      },
                      child: Container(
                          width: 110,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3285FF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: Text(
                            '''Aggiungi''',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ))),
                  GestureDetector(
                      onTap: () async {
                        await Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ),
                        );
                      },
                      child: Container(
                          width: 110,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3285FF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: Text(
                            '''Modifica''',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ))),
                  GestureDetector(
                      onTap: () async {
                        await Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ),
                        );
                      },
                      child: Container(
                          width: 110,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3285FF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: Text(
                            '''Elimina''',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ))),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 34, 1, 48),
      body: Stack(),
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
