import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/editProfile/EditFormPage.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/display_image_widget.dart';
import 'package:mytraining/screen/login.dart';

class Profilo2 extends StatefulWidget {
  @override
  State<Profilo2> createState() => _ProfiloState();
}

class _ProfiloState extends State<Profilo2> {
  final datasets = <String, dynamic>{};

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  //Profilo
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 10,
            ),
            const Center(
                child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(64, 105, 225, 1),
                      ),
                    ))),
            DisplayImage(
              imagePath:
                  "https://upload.wikimedia.org/wikipedia/en/0/0b/Darth_Vader_in_The_Empire_Strikes_Back.jpg",
              onPressed: () {},
            ),
            buildUserInfoDisplay(
                utentiModel.utenteBeingEdited.nomeUtente, 'Username'),
            buildUserInfoDisplay(utentiModel.utenteBeingEdited.nome, 'Nome'),
            buildUserInfoDisplay(
                utentiModel.utenteBeingEdited.cognome, 'Cognome'),
            buildUserInfoDisplay(utentiModel.utenteBeingEdited.eta, 'Eta'),
            buildUserInfoDisplay(
                utentiModel.utenteBeingEdited.height, 'Altezza'),
            buildUserInfoDisplay(utentiModel.utenteBeingEdited.weight, 'Peso'),
            Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 180, 212, 250),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                    border: Border.all(color: Colors.white)),
                margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.05,
                    left: MediaQuery.of(context).size.width * 0.675),
                child: Align(
                  child: TextButton(
                    child: Text(
                      "Modifica",
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
                    onPressed: () {
                      LoginPage().getValueLogin().then((val) async {
                        utentiModel.utenteBeingEdited =
                            await UtentiDBworker.utentiDBworker.get(val);
                      });
                      navigateSecondPage(const EditNameFormPage());
                      //utentiModel.setStackIndex(7);
                    },
                  ),
                  alignment: Alignment.center,
                )),
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.06,
                right: MediaQuery.of(context).size.width * 0.06, //20
                top: 20, //20
              ),
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              decoration: const BoxDecoration(),
              child: GestureDetector(
                  onTap: () {

                    utentiModel.setStackIndex(0);
                  },
                  child: Container(
                      width: 10,
                      height: 45,
                      padding: const EdgeInsets.only(top: 7),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          border: Border.all(color: Colors.white)),
                      child: Text(
                        '''Logout''',
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: Color(0xFFFFFFFF),
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
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: const Color.fromARGB(255, 180, 212, 250),
        selectedItemColor: Colors.white.withOpacity(0.5),
        unselectedItemColor: Colors.black,
        selectedFontSize: MediaQuery.of(context).size.height * 0.02,
        unselectedFontSize: MediaQuery.of(context).size.height * 0.02,
        onTap: (value) {
          //            setState(() => _currentIndex = value);
          if (value == 0) {
            utentiModel.setStackIndex(3);
          } else if (value == 1) {
            utentiModel.setStackIndex(4);
          }
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Homepage',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Schede',
            icon: Icon(Icons.article_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Profilo',
            icon: Icon(Icons.perm_identity_sharp),
          ),
        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title) => Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 40,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {},
                        child: Align(
                          child: Text(
                            getValue,
                            style: TextStyle(fontSize: 16, height: 1.4),
                          ),
                          alignment: Alignment.centerLeft,
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

/*class _ProfiloState extends State<Profilo2> {
  final datasets = <String, dynamic>{};

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  //Profilo
  int _currentIndex = 2;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 180, 212, 250),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    decoration: const BoxDecoration(),
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01,
                      top: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Text('MyTraining',
                        style: GoogleFonts.adventPro(
                          textStyle: TextStyle(
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery.of(context).size.height * 0.03,
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
                        right: MediaQuery.of(context).size.width * 0.03,
                        top: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          print("Mio nome utente: "+utentiModel.utenteBeingEdited.nomeUtente);
                        },
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.02,
                            width: MediaQuery.of(context).size.height * 0.02,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                border: Border.all(color: Colors.black, width: 1)),
                            child: Icon(
                              Icons.info,
                              size: MediaQuery.of(context).size.height * 0.02,
                              color: const Color(0xFF000000),
                            )),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 228, 229, 224),
      body: Container(
        child: ListView(
          children: [
            Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.06,  //20
                  top: 20,
                  right: MediaQuery.of(context).size.width * 0.60,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Container(
                    width: 10,
                    height: 45,
                    padding: const EdgeInsets.only(top: 7),
                    decoration: BoxDecoration(
                        color:  Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        border: Border.all(color: Colors.white)),
                    child: Text("  Nome Utente: "+
                        utentiModel.utenteBeingEdited.nomeUtente,
                      style: GoogleFonts.adventPro(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ))),
            Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.06,  //20
                  top: 20,
                  right: MediaQuery.of(context).size.width * 0.60,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Container(
                    width: 10,
                    height: 45,
                    padding: const EdgeInsets.only(top: 7),
                    decoration: BoxDecoration(
                        color:  Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        border: Border.all(color: Colors.white)),
                    child: Text("  Nome: "+
                        utentiModel.utenteBeingEdited.nome,
                      style: GoogleFonts.adventPro(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ))),
            Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.06,  //20
                  top: 20,
                  right: MediaQuery.of(context).size.width * 0.60,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Container(
                    width: 10,
                    height: 45,
                    padding: const EdgeInsets.only(top: 7),
                    decoration: BoxDecoration(
                        color:  Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        border: Border.all(color: Colors.white)),
                    child: Text("  Cognome: "+
                        utentiModel.utenteBeingEdited.cognome,
                      style: GoogleFonts.adventPro(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ))),
            Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.06,  //20
                  top: 20,
                  right: MediaQuery.of(context).size.width * 0.60,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Container(
                    width: 10,
                    height: 45,
                    padding: const EdgeInsets.only(top: 7),
                    decoration: BoxDecoration(
                        color:  Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        border: Border.all(color: Colors.white)),
                    child: Text("  Età: "+
                        utentiModel.utenteBeingEdited.eta,
                      style: GoogleFonts.adventPro(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ))),
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.06,  //20
                top: 20,
                right: MediaQuery.of(context).size.width * 0.06, //20
              ),
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              decoration: const BoxDecoration(),
              child: GestureDetector(
                  onTap: () {
                    utentiModel.setStackIndex(0);
                  },
                  child: Container(
                      width: 10,
                      height: 45,
                      padding: const EdgeInsets.only(top: 7),
                      decoration: BoxDecoration(
                          color:  Colors.red,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          border: Border.all(color: Colors.white)),
                      child: Text(
                        '''Logout''',
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: Color(0xFFFFFFFF),
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
          //            setState(() => _currentIndex = value);
          if (value == 0) {
            utentiModel.setStackIndex(3);
          } else if (value == 1) {
            utentiModel.setStackIndex(4);
          }
        },
        items: const[
          BottomNavigationBarItem(
            label: 'Homepage',
            icon:  Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Schede',
            icon:  Icon(Icons.article_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Profilo',
            icon:  Icon(Icons.perm_identity_sharp),
          ),
        ],
      ),

    );
  }
}*/

/*
bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              FlatButton(
                onPressed: (){
                  utentiModel.setStackIndex(0);
                },
                child: const Text("Logout"),
              ),
            ],
          )
      ),
 */
