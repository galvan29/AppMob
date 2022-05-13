import 'package:flutter/material.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/base.dart';
import 'package:mytraining/screen/schede.dart';
import 'package:mytraining/screen/visualizzaScheda.dart';

class CreaEsercizio extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context),
      backgroundColor: const Color.fromARGB(255, 42, 42, 42),
      body: Form(
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
                  "Crea un Esercizio!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                )),
            SizedBox(
                width: 330,
                child: Text(
                  "Compila tutti i parametri del form per crearne uno.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.adventPro(
                    textStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
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
                    maxLength: 20,
                    decoration: const InputDecoration(
                        labelText: "Nome Esercizio",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        counterText: ""),
                    initialValue: eserciziModel.esercizioBeingEdited == null
                        ? null
                        : eserciziModel.esercizioBeingEdited.nomeEsercizio,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Inserisci Nome Scheda";
                      }
                      return null;
                    },
                    onChanged: (String inValue) {
                      eserciziModel.esercizioBeingEdited.nomeEsercizio =
                          inValue;
                    },
                  ),
                )),
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
                    maxLength: 2,
                    decoration: const InputDecoration(
                        labelText: "Numero Serie",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        counterText: ""),
                    initialValue: eserciziModel.esercizioBeingEdited == null
                        ? null
                        : eserciziModel.esercizioBeingEdited.serieEsercizio,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Inserisci NUmero Serie";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    onChanged: (String inValue) {
                      eserciziModel.esercizioBeingEdited.serieEsercizio =
                          inValue;
                    },
                  ),
                )),
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
                    maxLength: 3,
                    decoration: const InputDecoration(
                        labelText: "Numero Ripetizioni",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        counterText: ""),
                    initialValue: eserciziModel.esercizioBeingEdited == null
                        ? null
                        : eserciziModel.esercizioBeingEdited.ripEsercizio,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Inserisci Numero Ripetizioni";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    onChanged: (String inValue) {
                      eserciziModel.esercizioBeingEdited.ripEsercizio = inValue;
                    },
                  ),
                )),
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
                    maxLength: 4,
                    decoration: const InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        counterText: ""),
                    initialValue: eserciziModel.esercizioBeingEdited == null
                        ? null
                        : eserciziModel.esercizioBeingEdited.pesoEsercizio,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Inserisci Peso";
                      }
                      return null;
                    },
                    onChanged: (String inValue) {
                      eserciziModel.esercizioBeingEdited.pesoEsercizio =
                          inValue;
                    },
                  ),
                )),
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
                    maxLength: 40,
                    decoration: const InputDecoration(
                        labelText: "Note",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        counterText: ""),
                    initialValue: eserciziModel.esercizioBeingEdited == null
                        ? null
                        : eserciziModel.esercizioBeingEdited.noteEsercizio,
                    /*validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Inserisci Note";
                      }
                      return null;
                    }, */
                    onChanged: (String inValue) {
                      eserciziModel.esercizioBeingEdited.noteEsercizio =
                          inValue;
                    },
                  ),
                )),
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
                      _save(context);
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
                        '''Aggiungi''',
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
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              FlatButton(
                onPressed: () {
                  schedeModel.setStackIndex(2);
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

  void _save(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    //_formKey.currentState.save();

    if (eserciziModel.esercizioBeingEdited.id == -1) {
      Schede().getValueScheda().then((val) async {
        eserciziModel.esercizioBeingEdited.idScheda = val.toString();
      });
      await EserciziDBworker.eserciziDBworker
          .create(eserciziModel.esercizioBeingEdited);
    } else {
      await EserciziDBworker.eserciziDBworker
          .update(eserciziModel.esercizioBeingEdited);
    }
    VisualizzaScheda.hoCaricatoGliEs = false;
    Schede().getValueScheda().then((val) async {
      await eserciziModel.loadData(EserciziDBworker.eserciziDBworker, val);
    });
    VisualizzaScheda.hoCaricatoGliEs = true;
    //print(VisualizzaScheda.hoCaricatoGliEs);
    Base.pageIndexForWidget=12;
    schedeModel.setStackIndex(6);
    //schedeModel.setStackIndex(2);
//dd
  }
}
