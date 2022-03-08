import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/db/eventiDBworrker.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/eventiModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      /*floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          //utentiModel.utenteBeingEdited = Utente();
          utentiModel.setStackIndex(3);
        },
      ),*/
      /*body: Stack(
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
                          textStyle: const TextStyle(
                            color: Color(0xFFFFFFFF),
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
                          textStyle: const TextStyle(
                            color: Color(0xFFFFFFFF),
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
                    padding: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
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
                           BorderSide(color: Colors.white, width: 0.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                           BorderSide(color: Colors.white, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:  BorderSide(
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
                        textStyle: const TextStyle(
                          color: Color(0xFFFFFFFF),
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
                    padding: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight:  Radius.circular(5),
                          bottomRight:  Radius.circular(5),
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
                           BorderSide(color: Colors.white, width: 0.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                           BorderSide(color: Colors.white, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                           BorderSide(color: Colors.white, width: 0.0),
                        ),
                        hintText: r'''Password''',
                        hintStyle:
                        TextStyle(fontSize: 16.0, color: Colors.white),
                        contentPadding: EdgeInsets.only(left: 15),
                      ),
                      style: GoogleFonts.adventPro(
                        textStyle: const TextStyle(
                          color: Color(0xFFFFFFFF),
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
                          //saveValueLogin(utente.id);
                          /*DatabaseHelper.istance.getPasswordVerified(usernameController.text).then((val) {
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
                                      builder: (context) => const PageLoginPage(),
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
                                  utentiModel.setStackIndex(1);
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
                          });*/
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
                                border:
                                Border.all(color: Colors.white, width: 2)),
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
                      )),
                ],
              ),
            ],
          ),
        ],
      ),*/
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                //initialValue: "Nome Utente",
                validator: (String? inValue) {
                  if (inValue!.isEmpty) {
                    return "Please enter a nome utente";
                  }
                  return null;
                },
                onChanged: (String inValue) {
                  utentiModel.utenteBeingEdited.nomeUtente = inValue;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.content_paste),
              title: TextFormField(
                maxLines: 1,
               // initialValue: "Password",
                validator: (String? inValue) {
                  if (inValue!.isEmpty) {
                    return "Please enter duration";
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
                decoration: const BoxDecoration(),
                child: GestureDetector(
                  onTap: () {
                    _save(context);
                    /*Utenti utente = new Utenti(nomeUtente: usernameController.text, password: passwordController.text);
                          DatabaseHelper.istance.getPasswordVerified(usernameController.text).then((val) {
                            if (val == '[]') {
                              print("Utente inesistente, procedo a creare utente");
                              DatabaseHelper.istance.add(utente);
                              utentiModel.setStackIndex(0);
                            } else {
                              // set up the buttons
                              Widget continueButton = TextButton(
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
                                  utentiModel.setStackIndex(1);
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
                                content: Text("Nome Utente già presente",
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
                          }); */
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
                          border: Border.all(color: Colors.white, width: 2)
                      ),
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
                      )
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              FlatButton(
                onPressed: (){
                  utentiModel.setStackIndex(0);
                },
                child: const Text("Cancel"),
              ),
            ],
          )
      ),
    );
  }

  void _save(BuildContext context) async {//dopo vedo cosa contiene
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
    }else{
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

    utentiModel.setStackIndex(3);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        content: Text("Login Effettuato"),
      ),
    );
  }
}