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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              FlatButton(
                onPressed: (){
                  utentiModel.setStackIndex(0);
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
      body: Form(
        key: _formKey,
        child: Stack(children: [
          Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/image/logoGym.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'MyTraining',
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 60,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        'Schedule your training',
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 30,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.72),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 50,
                      top: 20,
                      right: 50,
                    ),
                    padding: EdgeInsets.zero,
                    decoration: const BoxDecoration(),
                    child: Container(
                      width: double.maxFinite,
                      height: 40,
                      padding: const EdgeInsets.only(top: 7),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: TextFormField(
                        //initialValue: "Nome Utente",
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        validator: (String? inValue) {
                          if (inValue!.isEmpty) {
                            return "Please enter a nome utente";
                          }
                          return null;
                        },
                        onChanged: (String inValue) {
                          utentiModel.utenteBeingEdited.nomeUtente = inValue;
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 50,
                      top: 10,
                      right: 50,
                    ),
                    padding: EdgeInsets.zero,
                    decoration: const BoxDecoration(),
                    child: Container(
                      width: double.maxFinite,
                      height: 40,
                      padding: const EdgeInsets.only(top: 7),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: TextFormField(
                        /*decoration: InputDecoration(
                          labelText: "Password",
                        ),*/
                        obscureText: true,
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        validator: (String? inValue) {
                          if (inValue!.isEmpty) {
                            return "Please enter a password";
                          }
                          return null;
                        },
                        onChanged: (String inValue) {
                          utentiModel.utenteBeingEdited.password = inValue;
                        },
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                        left: 50,
                        top: 20,
                        right: 50,
                      ),
                      padding: EdgeInsets.zero,
                      decoration: const BoxDecoration(),
                      child: GestureDetector(
                        onTap: () {
                          print("CiaOOASFAF");
                          _save(context);
                        },
                        child: Container(
                            width: double.maxFinite,
                            height: 40,
                            padding: const EdgeInsets.only(top: 7),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.05),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                border:
                                Border.all(color: Colors.white, width: 2)),
                            child: Text(
                              '''Register''',
                              style: GoogleFonts.adventPro(
                                textStyle: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            )),
                      ))
                ],
              ))
        ]),
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
