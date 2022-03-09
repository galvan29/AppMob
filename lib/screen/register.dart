import 'package:flutter/material.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/login.dart';


class RegisterPage extends StatelessWidget{

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
                  utentiModel.setStackIndex(0);
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
                decoration: const InputDecoration(hintText: "Utente"),
                initialValue: utentiModel.utenteBeingEdited == null ? null : utentiModel.utenteBeingEdited.nomeUtente,
                validator: (String? inValue){
                  if(inValue!.isEmpty){
                    return "Inserire Utente";
                  }
                  return null;
                },
                onChanged: (String inValue){
                  utentiModel.utenteBeingEdited.nomeUtente = inValue;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                decoration: const InputDecoration(hintText: "Password"),
                initialValue: utentiModel.utenteBeingEdited == null ? null : utentiModel.utenteBeingEdited.password,
                validator: (String? inValue){
                  if(inValue!.isEmpty){
                    return "Inserire Password";
                  }
                  return null;
                },
                onChanged: (String inValue){
                  utentiModel.utenteBeingEdited.password = inValue;
                },
              ),
            ),
            /*ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                decoration: const InputDecoration(hintText: "Nome"),
                initialValue: utentiModel.utenteBeingEdited == null ? null : utentiModel.utenteBeingEdited.nome,
                validator: (String? inValue){
                  if(inValue!.isEmpty){
                    return "Inserire nome";
                  }
                  return null;
                },
                onChanged: (String inValue){
                  utentiModel.utenteBeingEdited.nome = inValue;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                decoration: const InputDecoration(hintText: "Cognome"),
                initialValue: utentiModel.utenteBeingEdited == null ? null : utentiModel.utenteBeingEdited.cognome,
                validator: (String? inValue){
                  if(inValue!.isEmpty){
                    return "Inserire cognome";
                  }
                  return null;
                },
                onChanged: (String inValue){
                  utentiModel.utenteBeingEdited.cognome = inValue;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                decoration: const InputDecoration(hintText: "Età"),
                maxLines: 1,
                keyboardType: TextInputType.number,
                initialValue: utentiModel.utenteBeingEdited == null ? null : utentiModel.utenteBeingEdited.eta,
                validator: (String? inValue){
                  if(inValue!.isEmpty){
                    return "Inserire Età";
                  }
                  return null;
                },
                onChanged: (String inValue){
                  utentiModel.utenteBeingEdited.eta = inValue;
                },
              ),
            ), */
          ],
        ),
      ),
    );
  }

  void _save(BuildContext context) async {
    print(context);   //dopo vedo cosa contiene
    if(!_formKey.currentState!.validate()){
      return;
    }

    //_formKey.currentState.save();

    //DEVO CONTROLLARE SE ESISTE O NO CON UN BEL GET

    if(utentiModel.utenteBeingEdited.id==-1){
      print("Utente CODDUE CREATO");
      print(utentiModel.utenteBeingEdited.id);
      print(utentiModel.utenteBeingEdited.nomeUtente);
      print(utentiModel.utenteBeingEdited.password);
      await UtentiDBworker.utentiDBworker.create(utentiModel.utenteBeingEdited);
    } //else {
    // await UtentiDBworker.utentiDBworker.update(utentiModel.utenteBeingEdited);
    //}

    utentiModel.loadData(UtentiDBworker.utentiDBworker);

    utentiModel.setStackIndex(1);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        content: Text("Utente creato"),
      ),
    );

  }
}
