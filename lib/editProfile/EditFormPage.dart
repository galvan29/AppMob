import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/base.dart';

import '../common/appbar.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

  void updateUserValue() {
    utentiModel.utenteBeingEdited.nomeUtente = userNameController.text;
    utentiModel.utenteBeingEdited.nome = firstNameController.text;
    utentiModel.utenteBeingEdited.cognome = secondNameController.text;
    utentiModel.utenteBeingEdited.eta = ageController.text;
    utentiModel.utenteBeingEdited.height = heightController.text;
    utentiModel.utenteBeingEdited.weight = weightController.text;
    print(utentiModel.utenteBeingEdited.nomeUtente);
  }

  var ciao = true;

  @override
  Widget build(BuildContext context) {
    if (ciao) {
      userNameController.text = utentiModel.utenteBeingEdited.nomeUtente;
      firstNameController.text = utentiModel.utenteBeingEdited.nome;
      secondNameController.text = utentiModel.utenteBeingEdited.cognome;
      ageController.text = utentiModel.utenteBeingEdited.eta;
      heightController.text = utentiModel.utenteBeingEdited.height;
      weightController.text = utentiModel.utenteBeingEdited.weight;
      ciao = false;
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      //appBar: buildAppBar(context),
      appBar: buildAppBar(context),
      backgroundColor: const Color.fromARGB(255, 42, 42, 42),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            SizedBox(
                width: 330,
                child: Text(
                  "Vuoi Cambiare qualcosa?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                )),




            Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      enabled: false,
                      // Handles Form Validation for First Name
                      validator: (String? inValue) {
                        if (inValue!.isEmpty) {
                          return "Inserire Nome Utente";
                        }
                        return null;
                      },
                      decoration:  InputDecoration(labelText: 'Username',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                      controller: userNameController,
                    ))),




            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                     /* validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      }, */
                      decoration: InputDecoration(labelText: 'Nome',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                      controller: firstNameController,
                    ))),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      // Handles Form Validation for First Name
                      /* validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        }, */
                      decoration:
                          const InputDecoration(labelText: 'Cognome',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                      controller: secondNameController,
                    ))),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      // Handles Form Validation for First Name
                      /* validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        }, */
                      decoration: const InputDecoration(labelText: 'Età',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                      controller: ageController,
                    ))),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      // Handles Form Validation for First Name
                      /* validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        }, */
                      decoration: const InputDecoration(labelText: 'Altezza',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                      controller: heightController,
                    ))),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      // Handles Form Validation for First Name
                      /* validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        }, */
                      decoration: const InputDecoration(labelText: 'Peso',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                      controller: weightController,
                    ))),



            Container(
              margin: const EdgeInsets.only(
                left: 30,
                top: 20,
                right: 30,
              ),
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              decoration: const BoxDecoration(),
              child: GestureDetector(
                  onTap: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      updateUserValue();
                      await UtentiDBworker.utentiDBworker
                          .update(utentiModel.utenteBeingEdited);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                      width: 10,
                      height: 50,
                      padding: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 230, 245, 252),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          border: Border.all(color: Colors.white)),
                      child: Text(
                        '''Aggiorna''',
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: const Color.fromARGB(255, 42, 42, 42),
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
      )),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
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
    );
  }
}
