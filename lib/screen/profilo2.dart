import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/editProfile/EditFormPage.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/login.dart';

import '../common/bottomNavigationBar.dart';

class Profilo2 extends StatefulWidget {
  @override
  State<Profilo2> createState() => _ProfiloState();
  static bool caricatoInfoProfilo = false;
}

class _ProfiloState extends State<Profilo2> {
  final datasets = <String, dynamic>{};

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  //Profilo
  final int _currentIndex = 2;

  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  @override
  void initState() {
    userNameController.text = utentiModel.utenteBeingEdited.nomeUtente;
    firstNameController.text = utentiModel.utenteBeingEdited.nome;
    secondNameController.text = utentiModel.utenteBeingEdited.cognome;
    ageController.text = utentiModel.utenteBeingEdited.eta;
    heightController.text = utentiModel.utenteBeingEdited.height;
    weightController.text = utentiModel.utenteBeingEdited.weight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    userNameController.text = utentiModel.utenteBeingEdited.nomeUtente;
    firstNameController.text = utentiModel.utenteBeingEdited.nome;
    secondNameController.text = utentiModel.utenteBeingEdited.cognome;
    ageController.text = utentiModel.utenteBeingEdited.eta;
    heightController.text = utentiModel.utenteBeingEdited.height;
    weightController.text = utentiModel.utenteBeingEdited.weight;
    
    /* print(ciao);
    if(ciao && utentiModel.stackIndex == 5){
      utentiModel.setStackIndex(7);
      Base.pageIndexForWidget = 5;
      print("sto aggiornando tutto");
      ciao = false;
    } */

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context),
      backgroundColor: const Color.fromARGB(255, 42, 42, 42),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 10,
            ),
            Container(
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              margin: EdgeInsets.only(
                bottom: MediaQuery
                    .of(context)
                    .size
                    .width * 0.07,
              ),
              decoration: const BoxDecoration(),
              child: Text(r'''Profilo''',
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 40,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1),
            ),
            Visibility(
                child: Column(
                  children: [
                    buildUserInfoDisplay(userNameController, 'Username'),
                    buildUserInfoDisplay(firstNameController, 'Nome'),
                    buildUserInfoDisplay(secondNameController, 'Cognome'),
                    buildUserInfoDisplay(ageController, 'Eta'),
                    buildUserInfoDisplay(heightController, 'Altezza'),
                    buildUserInfoDisplay(weightController, 'Peso'),
            ],
                ),
              visible: Profilo2.caricatoInfoProfilo,
              replacement: const CircularProgressIndicator(
                color: Colors.white
              ),
            ),
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.zero,
                      width: 150,
                      decoration: const BoxDecoration(),
                      margin: EdgeInsets.only(
                        left: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05,
                        bottom: MediaQuery
                            .of(context)
                            .size
                            .width * 0.08,
                      ),
                      child: GestureDetector(
                          onTap: () {
                            LoginPage().getValueLogin().then((val) async {
                              utentiModel.utenteBeingEdited =
                              await UtentiDBworker.utentiDBworker.get(val);
                            });
                            navigateSecondPage(const EditNameFormPage());
                            //utentiModel.setStackIndex(7);
                          },
                          child: Container(
                              width: 10,
                              height: 50,
                              padding: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 230, 245,
                                      252),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  border: Border.all(color: Colors.white)),
                              child: Text(
                                '''Modifica''',
                                style: GoogleFonts.adventPro(
                                  textStyle: const TextStyle(
                                    color: const Color.fromARGB(
                                        255, 42, 42, 42),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ))),
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      width: 150,
                      decoration: const BoxDecoration(),
                      margin: EdgeInsets.only(
                        right: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05,
                        bottom: MediaQuery
                            .of(context)
                            .size
                            .width * 0.08,
                      ),
                      child: GestureDetector(
                          onTap: () {
                            LoginPage().removeValueLogin();
                            utentiModel.setStackIndex(0);
                          },
                          child: Container(
                              width: 10,
                              height: 50,
                              padding: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 230, 220, 245),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  border: Border.all(color: Colors.white)),
                              child: Text(
                                '''Logout''',
                                style: GoogleFonts.adventPro(
                                  textStyle: const TextStyle(
                                    color: const Color.fromARGB(
                                        255, 42, 42, 42),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ))),
                    ),
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context, _currentIndex),
    );
  }

  Widget buildUserInfoDisplay(TextEditingController contr, String title) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.adventPro(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  height: 30,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ))),
                  child: Row(children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                            height: 70,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
                            child: TextFormField(
                              controller: contr,
                              enabled: false,
                              style: GoogleFonts.adventPro(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ))),
                  ]))
            ],
          ));

// Widget builds the About Me Section
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}




