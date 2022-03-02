import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/utentiModel.dart';

class RegisterPage extends StatelessWidget {
  final datasets = <String, dynamic>{};
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: (){
          //utentiModel.utenteBeingEdited = Utente();
          utentiModel.setStackIndex(1);
        },
      ),
      backgroundColor: const Color(0xFF000000),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                initialValue: "Nome Utente",
                validator: (String? inValue){
                  if(inValue!.isEmpty){
                    return "Please enter a nome utente";
                  }
                  return null;
                },
                onChanged: (String inValue){
                  utentiModel.utenteBeingEdited.nomeUtente = inValue;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.content_paste),
              title: TextFormField(
                keyboardType: TextInputType.number,
                maxLines: 1,
                initialValue: "Password",
                validator: (String? inValue){
                  if(inValue!.isEmpty){
                    return "Please enter duration";
                  }
                  return null;
                },
                onChanged: (String inValue){
                  utentiModel.utenteBeingEdited.password = inValue;
                },
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
                    _save(context);
                    /*Utenti utente = new Utenti(nomeUtente: usernameController.text, password: passwordController.text);
                          DatabaseHelper.istance.getPasswordVerified(usernameController.text).then((val) {
                            if (val == '[]') {
                              print("Utente inesistente, procedo a creare utente");
                              DatabaseHelper.istance.add(utente);
                              utentiModel.setStackIndex(0);
                            } else {
                              // set up the buttons
                              Widget continueButton = TextButton(
                                child: Text("Riprova",
                                  style: GoogleFonts.adventPro(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context).size.height * 0.016,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  utentiModel.setStackIndex(1);
                                },
                              );

                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text("Attenzione",
                                  style: GoogleFonts.adventPro(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: MediaQuery.of(context).size.height * 0.025,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                content: Text("Nome Utente già presente",
                                  style: GoogleFonts.adventPro(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context).size.height * 0.016,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                actions: [
                                  continueButton,
                                ],
                              );

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            }
                          }); */
                  },
                  child: Container(
                      width: double.maxFinite,
                      height: 40,
                      padding: const EdgeInsets.only(top:7),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          border: Border.all(color: Colors.white, width: 2)
                      ),
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
                      )
                  ),
                ))
          ],
        ),
      ),
      /* body: Stack(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/image/sfondo2.png",
                width: double.maxFinite,
                height: double.maxFinite,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.48,
                    ),
                    padding: EdgeInsets.zero,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(),
                    child: Text(r'''MyTraining''',
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontSize: 50,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    padding: EdgeInsets.zero,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(),
                    child: Text(r'''Register''',
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 50,
                      top: 70,
                      right: 50,
                    ),
                    width: double.maxFinite,
                    height: 40,
                    padding: const EdgeInsets.only(top:8),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        border: Border.all(color: Colors.white.withOpacity(0),)
                    ),
                    child: TextField(
                      controller: usernameController,
                      onChanged: (String value) async {},
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white, width: 0.0
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white, width: 0.0
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white, width: 0.0
                          ),
                        ),
                        hintText: r'''Nome Utente''',
                        hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                        contentPadding: EdgeInsets.only(left: 15),
                      ),
                      style: GoogleFonts.adventPro(
                        textStyle: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      minLines: 1,
                      maxLength: null,
                      obscureText: false,
                      showCursor: true,
                      autocorrect: false,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 50,
                      right: 50,
                    ),
                    width: double.maxFinite,
                    height: 40,
                    padding: const EdgeInsets.only(top:8),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        border: Border.all(color: Colors.white.withOpacity(0),)
                    ),
                    child: TextField(
                      controller: passwordController,
                      onChanged: (String value) async {},
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white, width: 0.0
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white, width: 0.0
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white, width: 0.0
                          ),
                        ),
                        hintText: r'''Password''',
                        hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                        contentPadding: EdgeInsets.only(left: 15),
                      ),
                      style: GoogleFonts.adventPro(
                        textStyle: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      minLines: 1,
                      maxLength: null,
                      obscureText: true,
                      showCursor: true,
                      autocorrect: false,
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
                          _save(context);
                          /*Utenti utente = new Utenti(nomeUtente: usernameController.text, password: passwordController.text);
                          DatabaseHelper.istance.getPasswordVerified(usernameController.text).then((val) {
                            if (val == '[]') {
                              print("Utente inesistente, procedo a creare utente");
                              DatabaseHelper.istance.add(utente);
                              utentiModel.setStackIndex(0);
                            } else {
                              // set up the buttons
                              Widget continueButton = TextButton(
                                child: Text("Riprova",
                                  style: GoogleFonts.adventPro(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context).size.height * 0.016,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  utentiModel.setStackIndex(1);
                                },
                              );

                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text("Attenzione",
                                  style: GoogleFonts.adventPro(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: MediaQuery.of(context).size.height * 0.025,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                content: Text("Nome Utente già presente",
                                  style: GoogleFonts.adventPro(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context).size.height * 0.016,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                actions: [
                                  continueButton,
                                ],
                              );

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            }
                          }); */
                        },
                        child: Container(
                            width: double.maxFinite,
                            height: 40,
                            padding: const EdgeInsets.only(top:7),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.05),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                border: Border.all(color: Colors.white, width: 2)
                            ),
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
                            )
                        ),
                      )),
                ],
              ),
            ],
          ),
        ],
      ), */
    );
  }



  void _save(BuildContext context) async {
    print(context);   //dopo vedo cosa contiene
    //if(!_formKey.currentState!.validate()){
    //  return;
    //}

    //_formKey.currentState.save();

    if(utentiModel.utenteBeingEdited.id==-1){
      await UtentiDBworker.utentiDBworker.create(utentiModel.utenteBeingEdited);
    } else {
      await UtentiDBworker.utentiDBworker.update(utentiModel.utenteBeingEdited);
    }

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
