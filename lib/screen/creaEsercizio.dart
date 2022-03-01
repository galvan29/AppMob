import 'package:flutter/material.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/models/schedeModel.dart';

class CreaEsercizio extends StatelessWidget{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                          //info
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
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              FlatButton(
                onPressed: (){
                  schedeModel.setStackIndex(2);
                },
                child: const Text("Cancel"),
              ),
              const Spacer(),
              FlatButton(
                onPressed: (){
                  _save(context);
                },
                child: const Text("Save"),
              ),
            ],
          )
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                decoration: const InputDecoration(hintText: "Nome Scheda"),
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
              ),
            ),
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                decoration: const InputDecoration(hintText: "Nome Scheda"),
                initialValue: eserciziModel.esercizioBeingEdited == null ? null : eserciziModel.esercizioBeingEdited.ripEsercizio,
                validator: (String? inValue){
                  if(inValue!.isEmpty){
                    return "Please enter a rip";
                  }
                  return null;
                },
                onChanged: (String inValue){
                  eserciziModel.esercizioBeingEdited.ripEsercizio = inValue;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                decoration: const InputDecoration(hintText: "Nome Scheda"),
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
              ),
            ),
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                decoration: const InputDecoration(hintText: "Nome Scheda"),
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
              ),
            ),
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                decoration: const InputDecoration(hintText: "Nome Scheda"),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _save(BuildContext context) async {

    if(!_formKey.currentState!.validate()){
      return;
    }

    //_formKey.currentState.save();

    if(eserciziModel.esercizioBeingEdited.id==-1){
      await EserciziDBworker.eserciziDBworker.create(eserciziModel.esercizioBeingEdited);
    } else {
      await EserciziDBworker.eserciziDBworker.update(eserciziModel.esercizioBeingEdited);
    }

    schedeModel.loadData(SchedeDBworker.schedeDBworker);
    eserciziModel.loadData(EserciziDBworker.eserciziDBworker);
    print("Ricaricati entrambi i database");
    schedeModel.setStackIndex(2);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        content: Text("Cards saved"),
      ),
    );

  }
}
