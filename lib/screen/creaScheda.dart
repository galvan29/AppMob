import 'package:flutter/material.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/base.dart';
import 'package:mytraining/screen/login.dart';

class CreaScheda extends StatelessWidget{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Crea la tua Scheda!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
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
                      style: TextStyle(color: Colors.white),
                      initialValue: schedeModel.schedaBeingEdited == null ? null : schedeModel.schedaBeingEdited.nomeScheda,
                      validator: (String? inValue){
                        if(inValue!.isEmpty){
                          return "Inserisci Nome";
                        }
                        return null;
                      },
                      onChanged: (String inValue){
                        schedeModel.schedaBeingEdited.nomeScheda = inValue;
                      },
                      decoration: const InputDecoration(labelText: "Nome Scheda",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                    ),)),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    initialValue: schedeModel.schedaBeingEdited == null ? null : schedeModel.schedaBeingEdited.durataScheda,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Inserisci Durata";
                      }
                      return null;
                    },
                    onChanged: (String inValue){
                      schedeModel.schedaBeingEdited.durataScheda = inValue;
                    },
                    decoration: const InputDecoration(labelText: "Durata Scheda",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
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
                  schedeModel.setStackIndex(0);
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
    print(context);   //dopo vedo cosa contiene
    if(!_formKey.currentState!.validate()){
      return;
    }

    //_formKey.currentState.save();

    if(schedeModel.schedaBeingEdited.id==-1){
      LoginPage().getValueLogin().then((val) async {
        schedeModel.schedaBeingEdited.idUtente = val.toString();
      });
      await SchedeDBworker.schedeDBworker.create(schedeModel.schedaBeingEdited);
    } else {
      await SchedeDBworker.schedeDBworker.update(schedeModel.schedaBeingEdited);
    }

    LoginPage().getValueLogin().then((val) async {
      await schedeModel.loadData(SchedeDBworker.schedeDBworker, val);
    });

    Base.pageIndexForWidget=0;
    schedeModel.setStackIndex(6);



  }
}
