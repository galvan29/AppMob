import 'dart:io';

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
import 'utente.dart';
import 'creaScheda.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageSchedePage extends StatefulWidget {
  const PageSchedePage({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();

  void aggiungi(SchedeStruct scheda) {
    _schede.add(scheda);
  }

  void rimuovi(SchedeStruct scheda) {
    _schede.removeWhere((item) => item.id == 1);
  }
}

List<SchedeStruct> _schede = [];

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
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(color: const Color.fromARGB(255, 180, 212, 250), border: Border.all(color: Colors.black, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      decoration: const BoxDecoration(),
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Text('CARDS',
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
                    ),
                    Container(
                        padding: EdgeInsets.zero,
                        decoration: const BoxDecoration(),
                        margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            await Navigator.push<void>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PageUtentePage(),
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
                                Icons.perm_identity_sharp,
                                size: MediaQuery.of(context).size.height * 0.037,
                                color: Color(0xFF000000),
                              )),
                        ))
                  ],
                ),
              ),
              Container(
                height: 0,
                width: MediaQuery.of(context).size.height * 1,
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
        backgroundColor: const Color.fromARGB(255, 205, 225, 247),
        body: Container(
          child: new SingleChildScrollView(
            child: Column(
              children: [
                //for (var scheda in _schede)
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width * 0.05,
                    ),
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        border: Border.all(
                          color: Colors.black,
                        )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              width: MediaQuery.of(context).size.width * 0.30,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  )),
                              child: Text("Nome Scheda",
                                  style: GoogleFonts.adventPro(
                                    textStyle: TextStyle(
                                      color: const Color(0xFF000000),
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context).size.width * 0.05,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  textAlign: TextAlign.left,
                                  maxLines: 1),
                            ),
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  )),
                              child: Text("Durata Scheda",
                                  style: GoogleFonts.adventPro(
                                    textStyle: TextStyle(
                                      color: const Color(0xFF000000),
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  textAlign: TextAlign.left,
                                  maxLines: 1),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.25,
                          ),
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                              border: Border.all(
                                color: Colors.black,
                              )),
                          child: GestureDetector(
                              child: Container(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text(
                                    "START",
                                    style: GoogleFonts.adventPro(
                                      textStyle: TextStyle(
                                        color: const Color(0xFF000000),
                                        fontWeight: FontWeight.w400,
                                        fontSize: MediaQuery.of(context).size.width * 0.035,
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ))),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.01,
                          ),
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                              border: Border.all(
                                color: Colors.black,
                              )),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              customButton: Icon(
                                Icons.list,
                                size: 46,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                              customItemsIndexes: const [
                                3
                              ],
                              customItemsHeight: 8,
                              items: [
                                ...MenuItems.firstItems.map(
                                      (item) => DropdownMenuItem<MenuItem>(
                                    value: item,
                                    child: MenuItems.buildItem(item),
                                  ),
                                ),
                                const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
                                ...MenuItems.secondItems.map(
                                      (item) => DropdownMenuItem<MenuItem>(
                                    value: item,
                                    child: MenuItems.buildItem(item),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                MenuItems.onChanged(context, value as MenuItem);
                              },
                              itemHeight: 48,
                              itemPadding: const EdgeInsets.only(left: 16, right: 16),
                              dropdownWidth: 160,
                              dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: const Color.fromARGB(255, 180, 212, 250),
                              ),
                              dropdownElevation: 8,
                              offset: const Offset(0, 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                //pulsante add per nuova scheda
                Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    decoration: const BoxDecoration(),
                    child: GestureDetector(
                      onTap: () async {
                        PageSchedePage().aggiungi(SchedeStruct(1, "Nome Scheda", 120));
                        await Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreaScheda(),
                          ),
                        );
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.10,
                          height: MediaQuery.of(context).size.height * 0.040,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.05),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              border: Border.all(color: Colors.black, width: 1)),
                          child: Icon(
                            Icons.add,
                            size: MediaQuery.of(context).size.height * 0.037,
                            color: Color(0xFF000000),
                          )),
                    )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: const Color.fromARGB(255, 180, 212, 250),
          selectedItemColor: Colors.white.withOpacity(0.5),
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

class Schede {
  final String nomeUtente;
  final String nome;
  final String durata;

  Schede({required this.nomeUtente, required this.nome, required this.durata});

  factory Schede.fromMap(Map<String, dynamic> json) =>
      new Schede(nomeUtente: json['nomeUtente'], nome: json['nome'], durata: json['durata']);

  Map<String, dynamic> toMap() {
    return {
      'nomeUtente': nomeUtente,
      'nome': nome,
      'durata': durata,
    };
  }
}

class DatabaseHelper2 {
  DatabaseHelper2._privateConstructur();

  static final DatabaseHelper2 istance = DatabaseHelper2._privateConstructur();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'schede.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE schede(
        nomeUtente TEXT,
        nome TEXT PRIMARY KEY,
        durata TEXT
      ) 
    ''');
  }

  Future<List<Schede>> getSchede(String nomeUtente) async {
    Database db = await istance.database;
    var schede = await db.query('schede',
        columns: ['nome', 'durata'],
        where: 'nomeUtente = ?',
        whereArgs: [nomeUtente]);
    List<Schede> schedeList = schede.isNotEmpty
        ?  schede.map((c) => Schede.fromMap(c)).toList()
    : [];
    return schedeList;
  }

  Future<int> add(Schede scheda) async {
    Database db = await istance.database;
    print("Utente creato");
    return await db.insert('utenti', scheda.toMap());
  }
}