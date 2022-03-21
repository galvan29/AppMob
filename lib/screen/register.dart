import 'package:flutter/material.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/base.dart';
import 'package:mytraining/screen/login.dart';

class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      const SizedBox(height: 15.0),
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
                                onTap: () {},
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
                                  } //else if (inValue.length < 8) {
                                  //  return "Please enter a password of length maggiore di 8";
                                 // }
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
                            onTap: () async {
                              Utente u = await UtentiDBworker.utentiDBworker
                                  .getId(utentiModel.utenteBeingEdited.nomeUtente);
                              if (u.id == -1) {
                                _save(context);
                              } else {
                                Widget riprovaButton = TextButton(
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
                                    "Nome Utente già presente",
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
                                    riprovaButton,
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
                                  'Register',
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
                  )))
        ]),
      ),
    );
  }

  void _save(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    //_formKey.currentState.save();

    //DEVO CONTROLLARE SE ESISTE O NO CON UN BEL GET

    if (utentiModel.utenteBeingEdited.id == -1) {
      await UtentiDBworker.utentiDBworker.create(utentiModel.utenteBeingEdited);
    } //else {
    // await UtentiDBworker.utentiDBworker.update(utentiModel.utenteBeingEdited);
    //}

    utentiModel.loadData(UtentiDBworker.utentiDBworker);
    Base.pageIndexForWidget=1;
    utentiModel.setStackIndex(7);
    //utentiModel.setStackIndex(1);


  }
}
