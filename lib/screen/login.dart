import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/db/eventiDBworrker.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/eventiModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/base.dart';
import 'package:mytraining/screen/visualizzaScheda.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              FlatButton(
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
                      /*Container(
                        margin: EdgeInsets.only(top: 0),
                        child: Text(
                          'Login',
                          style: GoogleFonts.adventPro(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ), */
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
             child:
         Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.75),
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
                        child: Container(
                            width: double.maxFinite,
                            height: 40,
                            padding: const EdgeInsets.only(top: 0, left: 10),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.05),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                            child: Container(
                              child: TextFormField(
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
                                  contentPadding: EdgeInsets.only(bottom: 10),
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
                                ),
                                validator: (String? inValue) {
                                  if (inValue!.isEmpty) {
                                    return "Please enter a nome utente";
                                  }
                                  return null;
                                },
                                onChanged: (String inValue) {
                                  utentiModel.utenteBeingEdited.nomeUtente =
                                      inValue;
                                },
                                onTap: (){

                                },
                              ),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 50,
                          top: 10,
                          right: 50,
                        ),
                        padding: EdgeInsets.zero,
                        decoration: const BoxDecoration(),
                        child: Container(
                            width: double.maxFinite,
                            height: 40,
                            padding: const EdgeInsets.only(top: 0, left: 10),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.05),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                            child: Container(
                              child: TextFormField(
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
                                  contentPadding: EdgeInsets.only(bottom: 10),
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
                                ),
                                validator: (String? inValue) {
                                  if (inValue!.isEmpty) {
                                    return "Please enter a password";
                                  }
                                  return null;
                                },
                                onChanged: (String inValue) {
                                  utentiModel.utenteBeingEdited.password =
                                      inValue;
                                },
                              ),
                            )),
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
                              _save(context);
                            },
                            child: Container(
                                width: double.maxFinite,
                                height: 40,
                                padding: const EdgeInsets.only(top: 7),
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
                                  '''Login''',
                                  style: GoogleFonts.adventPro(
                                    textStyle: const TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                          ))
                    ],
                  ))
                  )
        ]),
      ),
    );
  }

  void _save(BuildContext context) async {
    //dopo vedo cosa contiene
    if (!_formKey.currentState!.validate()) {
      return;
    }
    print("BROOOOOOOOOOOOOOOO");
    //_formKey.currentState.save();
    // FACCIO UN GET NOMEUTENTE DATO L'ID E VEDO COSA RITORNA
    //await per password
    await utentiModel.getPassword(UtentiDBworker.utentiDBworker,
        utentiModel.utenteBeingEdited.nomeUtente);
    String passwordDatabase = utentiModel.up.password;
    print("Nome utente inserito. " + utentiModel.utenteBeingEdited.nomeUtente);
    print("Password inserita. " + utentiModel.utenteBeingEdited.password);
    print("Password trovata. " + passwordDatabase);
    if (utentiModel.utenteBeingEdited.password == passwordDatabase) {
      print("Password corrispondente");
      await utentiModel.getPassword(UtentiDBworker.utentiDBworker,
          utentiModel.utenteBeingEdited.nomeUtente);
      saveValueLogin(utentiModel.up.id);
    } else {
      print("Password diversa");
      return;
    }
    print("LOGGGGATO E CARICO SCHEDE");
    //CARICARE SOLO SCHEDE DEL TIPO CHE SI è LOGGATO
    getValueLogin().then((val) async {
      await schedeModel.loadData(SchedeDBworker.schedeDBworker, val);
      await eventiModel.loadData(EventiDBworker.eventiDBworker, val);
    });

    //utentiModel.loadData(UtentiDBworker.utentiDBworker);

    Base.pageIndexForWidget = 3;
    utentiModel.setStackIndex(7);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        content: Text("Login Effettuato"),
      ),
    );
  }

  BackBro() {
    utentiModel.setStackIndex(0);
  }
}
