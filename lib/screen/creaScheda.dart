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
                      initialValue: schedeModel.schedaBeingEdited == null ? null : schedeModel.schedaBeingEdited.nomeScheda,
                      validator: (String? inValue){
                        if(inValue!.isEmpty){
                          return "Please enter a name";
                        }
                        return null;
                      },
                      onChanged: (String inValue){
                        schedeModel.schedaBeingEdited.nomeScheda = inValue;
                      },
                      decoration: const InputDecoration(labelText: "Nome Scheda"),
                    ),)),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: schedeModel.schedaBeingEdited == null ? null : schedeModel.schedaBeingEdited.durataScheda,
                    validator: (String? inValue){
                      if(inValue!.isEmpty){
                        return "Please enter a durata";
                      }
                      return null;
                    },
                    onChanged: (String inValue){
                      schedeModel.schedaBeingEdited.durataScheda = inValue;
                    },
                    decoration: const InputDecoration(labelText: "Durata Scheda"),
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
                  schedeModel.setStackIndex(0);
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        content: Text("Cards saved"),
      ),
    );

  }
}
