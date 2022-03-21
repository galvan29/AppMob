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

class CreaEsercizio extends StatelessWidget{

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
            const SizedBox(
                width: 330,
                child: Text(
                  "Crea un esercizio!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "Nome Esercizio",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                    initialValue: eserciziModel.esercizioBeingEdited == null ? null : eserciziModel.esercizioBeingEdited.nomeEsercizio,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Inserisci Nome";
                      }
                      return null;
                    },
                    onChanged: (String inValue){
                      eserciziModel.esercizioBeingEdited.nomeEsercizio = inValue;
                    },
                  ),)),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child:  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "Serie",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                    initialValue: eserciziModel.esercizioBeingEdited == null ? null : eserciziModel.esercizioBeingEdited.serieEsercizio,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Inserisci Serie";
                      }
                      return null;
                    },
                    onChanged: (String inValue){
                      eserciziModel.esercizioBeingEdited.serieEsercizio = inValue;
                    },
                  ),)),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "Ripetizioni",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                    initialValue: eserciziModel.esercizioBeingEdited == null ? null : eserciziModel.esercizioBeingEdited.ripEsercizio,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Inserisci Ripetizioni";
                      }
                      return null;
                    },
                    onChanged: (String inValue){
                      eserciziModel.esercizioBeingEdited.ripEsercizio = inValue;
                    },
                  ),)),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "Peso",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                    initialValue: eserciziModel.esercizioBeingEdited == null ? null : eserciziModel.esercizioBeingEdited.pesoEsercizio,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Inserisci Peso";
                      }
                      return null;
                    },
                    onChanged: (String inValue){
                      eserciziModel.esercizioBeingEdited.pesoEsercizio = inValue;
                    },
                  ),)),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "Note",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                    initialValue: eserciziModel.esercizioBeingEdited == null ? null : eserciziModel.esercizioBeingEdited.noteEsercizio,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Inserisci Note";
                      }
                      return null;
                    },
                    onChanged: (String inValue){
                      eserciziModel.esercizioBeingEdited.noteEsercizio = inValue;
                    },
                  ),)),
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
                onPressed: (){
                  schedeModel.setStackIndex(2);
                },
                child: Text("Indietro",
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
          )
      ),
    );
  }

  void _save(BuildContext context) async {

    if(!_formKey.currentState!.validate()){
      return;
    }

    //_formKey.currentState.save();

    if(eserciziModel.esercizioBeingEdited.id==-1){
      Schede().getValueScheda().then((val) async {
        eserciziModel.esercizioBeingEdited.idScheda = val.toString();
      });
      await EserciziDBworker.eserciziDBworker.create(eserciziModel.esercizioBeingEdited);
    } else {
      await EserciziDBworker.eserciziDBworker.update(eserciziModel.esercizioBeingEdited);
    }

    Schede().getValueScheda().then((val) async {
      await eserciziModel.loadData(EserciziDBworker.eserciziDBworker, val);
    });

    Base.pageIndexForWidget=12;
    schedeModel.setStackIndex(6);
//dd


  }
}
