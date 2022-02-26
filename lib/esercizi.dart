import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helloworld/creaEsercizio.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'bro.dart';
import 'login.dart';
import 'main.dart';
import 'options.dart';
import 'profile.dart';
import 'schede.dart';
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

class PageEserciziPage extends StatefulWidget {
  const PageEserciziPage({
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

  getValueLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = "";
    stringValue = prefs.getString('id')!;
    return stringValue;
  }
}

List<SchedeStruct> _schede = [];

class _State extends State<PageEserciziPage> {
  final datasets = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
  }

  saveValueIdScheda(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
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
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 180, 212, 250),
                    border: Border.all(color: Colors.black, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      decoration: const BoxDecoration(),
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Text('Nome Scheda',
                          style: GoogleFonts.adventPro(
                            textStyle: TextStyle(
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontSize:
                              MediaQuery.of(context).size.height * 0.05,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 1),
                    ),
                    Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.04,
                          left: MediaQuery.of(context).size.width * 0.25,
                        ),
                        decoration: const BoxDecoration(),
                        child: GestureDetector(
                          onTap: () async {
                            await Navigator.push<void>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreaEsercizio(),
                              ),
                            );
                          },
                          child: Container(
                              width: 60,
                              height: 60,
                              // MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.05),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              child: Icon(
                                Icons.add,
                                size:
                                MediaQuery.of(context).size.height * 0.037,
                                color: Color(0xFF000000),
                              )),
                        )),
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
                                  border: Border.all(
                                      color: Colors.black, width: 2)),
                              child: Icon(
                                Icons.perm_identity_sharp,
                                size:
                                MediaQuery.of(context).size.height * 0.037,
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
          child: FutureBuilder<List<Esercizi>>(
              future: DatabaseHelper3.istance.getEsercizi(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Esercizi>> snapshot) {
                if (!snapshot.hasData) return Center(child: Text("Loading..."));
                return snapshot.data!.isEmpty
                    ? Center(child: Text("No element"))
                    : ListView(
                  children: snapshot.data!.map((esercizi) {
                    return Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 50,
                            right: 50,
                            top: 20,
                          ),
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height * 0.09,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              border: Border.all(
                                color: Colors.black,
                              )),
                          child: ListTile(
                            title: Text(esercizi.nome),
                            subtitle: Text("Peso:" +
                                esercizi.peso.toString() +
                                "\nRipetizioni: " +
                                esercizi.rip.toString() +
                                "\nSerie: " +
                                esercizi.serie.toString() +
                                "\nNote: " +
                                esercizi.note.toString()),
                            onTap: () {
                              saveValueIdScheda("Id esercizio: "+esercizi.id.toString());
                            },
                          ),
                        ));
                  }).toList(),
                );
              }),
          //pulsante add per nuova scheda
          /*   Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    decoration: const BoxDecoration(),
                    child: GestureDetector(
                      onTap: () async {
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
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Icon(
                            Icons.add,
                            size: MediaQuery.of(context).size.height * 0.037,
                            color: Color(0xFF000000),
                          )),
                    )),*/
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Training()));
            else if (value == 2)
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewGraph()));
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

class Esercizi {
  final String? id;
  final String idScheda;
  final String nome;
  final String rip;
  final String serie;
  final String peso;
  final String note;

  Esercizi({
    this.id,
    required this.idScheda,
    required this.nome,
    required this.rip,
    required this.serie,
    required this.peso,
    required this.note,
  });

  factory Esercizi.fromMap(Map<String, dynamic> json) => new Esercizi(
      id: json['id'],
      idScheda: json['idScheda'],
      nome: json['nome'],
      rip: json['rip'],
      serie: json['serie'],
      peso: json['peso'],
      note: json['note']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idScheda': idScheda,
      'nome': nome,
      'rip': rip,
      'serie': serie,
      'peso': peso,
      'note': note
    };
  }
}

class DatabaseHelper3 {
  DatabaseHelper3._privateConstructur();

  static final DatabaseHelper3 istance = DatabaseHelper3._privateConstructur();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'esercizi.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE esercizi(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idScheda TEXT,
        nome TEXT,
        rip TEXT,
        serie TEXT,
        peso TEXT,
        note TEXT
      ) 
    ''');
  }

  Future<List<Esercizi>> getEsercizi() async {
    String str = "";
    PageSchedePage().getValueIdScheda().then((val) {
      str = val;
    });
    Database db = await istance.database;
    var esercizi = await db.query('esercizi',
        columns: ['nome', 'rip', 'serie', 'peso', 'note'],
        where: 'idScheda = ?',
        whereArgs: [str]);
    List<Esercizi> eserciziList = esercizi.isNotEmpty
        ? esercizi.map((c) => Esercizi.fromMap(c)).toList()
        : [];
    print("Recupero esercizi: ");
    return eserciziList;
  }

  Future<int> add(Esercizi esercizio) async {
    Database db = await istance.database;
    print("Esercizio creato");
    return await db.insert('esercizi', esercizio.toMap());
  }
}
