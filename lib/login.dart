import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helloworld/register.dart';
import 'package:sqflite/sqflite.dart';
import 'schede.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageLoginPage extends StatefulWidget {
  const PageLoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();

  getValueLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue="";
    stringValue = prefs.getString('nomeUtente')!;
    return stringValue;
  }
}


class _State extends State<PageLoginPage> {
  final datasets = <String, dynamic>{};
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  saveValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nomeUtente', usernameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF000000),
      body: Stack(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/image/sfondo2.png",
                width: double.maxFinite,
                height: double.maxFinite,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.48,
                    ),
                    padding: EdgeInsets.zero,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(),
                    child: Text(r'''MyTraining''',
                        style: GoogleFonts.adventPro(
                          textStyle: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontSize: 50,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    padding: EdgeInsets.zero,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(),
                    child: Text(r'''Login''',
                        style: GoogleFonts.adventPro(
                          textStyle: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 50,
                      top: 92,
                      right: 50,
                    ),
                    width: double.maxFinite,
                    height: 50,
                    padding: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0),
                        )),
                    child: TextField(
                      controller: usernameController,
                      onChanged: (String value) async {},
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 0.0,
                          ),
                        ),
                        hintText: r'''Nome Utente''',
                        hintStyle:
                            TextStyle(fontSize: 16.0, color: Colors.white),
                        contentPadding: EdgeInsets.only(left: 15),
                      ),
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      minLines: 1,
                      maxLength: null,
                      obscureText: false,
                      showCursor: true,
                      autocorrect: false,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 50,
                      right: 50,
                    ),
                    width: double.maxFinite,
                    height: 50,
                    padding: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0),
                        )),
                    child: TextField(
                      controller: passwordController,
                      onChanged: (String value) async {},
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        hintText: r'''Password''',
                        hintStyle:
                            TextStyle(fontSize: 16.0, color: Colors.white),
                        contentPadding: EdgeInsets.only(left: 15),
                      ),
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      minLines: 1,
                      maxLength: null,
                      obscureText: true,
                      showCursor: true,
                      autocorrect: false,
                    ),
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
                          DatabaseHelper.istance.getPasswordVerified(usernameController.text).then((val) {
                            if (val == passwordController.text) {
                              saveValue();
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PageSchedePage(),
                                ),
                              );
                            } else {
                              // set up the buttons
                              Widget cancelButton = TextButton(
                                child: Text("Riprova",
                                  style: GoogleFonts.adventPro(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context).size.height * 0.016,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PageLoginPage(),
                                    ),
                                  );
                                },
                              );
                              Widget continueButton = TextButton(
                                child: Text("Registrati",
                                  style: GoogleFonts.adventPro(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context).size.height * 0.016,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PageRegisterPage(),
                                    ),
                                  );
                                },
                              );

                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text("Attenzione",
                                  style: GoogleFonts.adventPro(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: MediaQuery.of(context).size.height * 0.025,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                content: Text("Nome Utente o Password errata",
                                  style: GoogleFonts.adventPro(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context).size.height * 0.016,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                actions: [
                                  cancelButton,
                                  continueButton,
                                ],
                              );

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            }
                          });
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
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Utenti {
  final String nomeUtente;
  final String password;

  Utenti({required this.nomeUtente, required this.password});

  factory Utenti.fromMap(Map<String, dynamic> json) =>
      new Utenti(nomeUtente: json['nomeUtente'], password: json['password']);

  Map<String, dynamic> toMap() {
    return {
      'nomeUtente': nomeUtente,
      'password': password,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructur();

  static final DatabaseHelper istance = DatabaseHelper._privateConstructur();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'utenti.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE utenti(
        nomeUtente TEXT PRIMARY KEY,
        password TEXT
      ) 
    ''');
  }

  Future<String> getPasswordVerified(String nomeUtente) async {
    Database db = await istance.database;
    var utenteConTutto = await db.query('utenti',
        columns: ['password'],
        where: 'nomeUtente = ?',
        whereArgs: [nomeUtente]);
    String pass = utenteConTutto
        .toString()
        .replaceAll("[{password: ", "")
        .replaceAll("}]", "");
    return pass;
  }

  Future<int> add(Utenti utente) async {
    Database db = await istance.database;
    print("Utente creato");
    return await db.insert('utenti', utente.toMap());
  }
}
