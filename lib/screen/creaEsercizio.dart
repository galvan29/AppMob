import 'package:flutter/material.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/screen/schede.dart';

class CreaEsercizio extends StatelessWidget{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context),
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
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Nome Esercizio"),
                    initialValue: eserciziModel.esercizioBeingEdited == null ? null : eserciziModel.esercizioBeingEdited.nomeEsercizio,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Please enter a name";
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
                    decoration: const InputDecoration(labelText: "Serie"),
                    initialValue: eserciziModel.esercizioBeingEdited == null ? null : eserciziModel.esercizioBeingEdited.serieEsercizio,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Please enter a serie";
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
                    decoration: const InputDecoration(labelText: "Rip"),
                    initialValue: eserciziModel.esercizioBeingEdited == null ? null : eserciziModel.esercizioBeingEdited.ripEsercizio,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Please enter a serie";
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
                    decoration: const InputDecoration(labelText: "Peso"),
                    initialValue: eserciziModel.esercizioBeingEdited == null ? null : eserciziModel.esercizioBeingEdited.pesoEsercizio,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Please enter a peso";
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
                    decoration: const InputDecoration(labelText: "Note"),
                    maxLines: 2,
                    initialValue: eserciziModel.esercizioBeingEdited == null ? null : eserciziModel.esercizioBeingEdited.noteEsercizio,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Please enter a note";
                      }
                      return null;
                    },
                    onChanged: (String inValue){
                      eserciziModel.esercizioBeingEdited.noteEsercizio = inValue;
                    },
                  ),)),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 330,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            _save(context);
                          }
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    )))
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
                      color: Colors.black,
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
    schedeModel.setStackIndex(2);
//dd
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        content: Text("Esercizio saved"),
      ),
    );

  }
}
