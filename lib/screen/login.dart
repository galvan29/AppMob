import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/db/eventiDBworrker.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/eventiModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  final datasets = <String, dynamic>{};
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  saveValueLogin(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('idUtente', id);
  }

  getValueLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idUtente')!;
  }

  removeValueLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  utentiModel.setStackIndex(0);
                },
                child: Text(
                  "Indietro",
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ],
          )),
      body: Form(
        key: _formKey,
        child: Stack(children: [
          Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/image/logoGym.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'MyTraining',
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 60,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'Schedule your training',
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 30,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.72),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 50,
                          top: 10,
                          right: 50,
                        ),
                        padding: EdgeInsets.zero,
                        decoration: const BoxDecoration(),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          //initialValue: "Password",
                          obscureText: false,
                          style: GoogleFonts.adventPro(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                          ),
                          decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(bottom: 10, left: 10),
                        hintText: 'Nome Utente',
                        hintStyle: GoogleFonts.adventPro(
                          textStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                          ),
                          validator: (String? inValue) {
                        if (inValue!.isEmpty) {
                          return "Please enter a nome utente";
                        }
                        return null;
                          },
                          onChanged: (String inValue) {
                        utentiModel.utenteBeingEdited.nomeUtente = inValue;
                          },
                          onTap: () {},
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 50,
                          top: 10,
                          right: 50,
                        ),
                        padding: EdgeInsets.zero,
                        decoration: const BoxDecoration(),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          //initialValue: "Password",
                          obscureText: true,
                          style: GoogleFonts.adventPro(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(bottom: 10, left: 10),
                            hintText: 'Password',
                            hintStyle: GoogleFonts.adventPro(
                              textStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                          ),
                          validator: (String? inValue) {
                            if (inValue!.isEmpty) {
                              return "Please enter a password";
                            }
                            return null;
                          },
                          onChanged: (String inValue) {
                            utentiModel.utenteBeingEdited.password = inValue;
                          },
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                            left: 50,
                            top: 20,
                            right: 50,
                          ),
                          padding: EdgeInsets.zero,
                          width: double.maxFinite,
                          decoration: const BoxDecoration(),
                          child: GestureDetector(
                            onTap: () async {
                              await utentiModel.getPassword(
                                  UtentiDBworker.utentiDBworker,
                                  utentiModel.utenteBeingEdited.nomeUtente);
                              String passwordDatabase = utentiModel.up.password;
                              if (utentiModel.utenteBeingEdited.password ==
                                  passwordDatabase) {
                                await utentiModel.getPassword(
                                    UtentiDBworker.utentiDBworker,
                                    utentiModel.utenteBeingEdited.nomeUtente);
                                _save(context);
                              } else {
                                Widget cancelButton = TextButton(
                                  child: Text(
                                    "Riprova",
                                    style: GoogleFonts.adventPro(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.016,
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                                Widget continueButton = TextButton(
                                  child: Text(
                                    "Registrati",
                                    style: GoogleFonts.adventPro(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.016,
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    utentiModel.setStackIndex(2);
                                  },
                                );

                                // set up the AlertDialog
                                AlertDialog alert = AlertDialog(
                                  title: Text(
                                    "Attenzione",
                                    style: GoogleFonts.adventPro(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  content: Text(
                                    "Nome Utente o Password errata",
                                    style: GoogleFonts.adventPro(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.016,
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
                            },
                            child: Container(
                                width: 10,
                                height: 45,
                                padding: const EdgeInsets.only(top: 9),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.05),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 2)),
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.adventPro(
                                    textStyle: const TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                          ))
                    ],
                  )))
        ]),
      ),
    );
  }

  void _save(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      print("Errore del login");
      return;
    }
    saveValueLogin(utentiModel.up.id);
    getValueLogin().then((val) async {
      await schedeModel.loadData(SchedeDBworker.schedeDBworker, val);
      await eventiModel.loadData(EventiDBworker.eventiDBworker, val);
      utentiModel.utenteBeingEdited = await UtentiDBworker.utentiDBworker.get(val);
    });

    Base.pageIndexForWidget = 3;
    utentiModel.setStackIndex(7);
  }

  backBro() {
    utentiModel.setStackIndex(0);
  }
}
