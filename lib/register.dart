import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helloworld/login.dart';

import 'schede.dart';

class PageRegisterPage extends StatefulWidget {
  const PageRegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PageRegisterPage> {
  final datasets = <String, dynamic>{};
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color(0xFF000000),
      body: Stack(
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
                          textStyle: TextStyle(
                            color: const Color(0xFFFFFFFF),
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
                          textStyle: TextStyle(
                            color: const Color(0xFFFFFFFF),
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
                    padding: EdgeInsets.only(top:8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
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
                          borderSide: const BorderSide(
                              color: Colors.white, width: 0.0
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.white, width: 0.0
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.white, width: 0.0
                          ),
                        ),
                        hintText: r'''Nome Utente''',
                        hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                        contentPadding: EdgeInsets.only(left: 15),
                      ),
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: const Color(0xFFFFFFFF),
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
                    padding: EdgeInsets.only(top:8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
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
                          borderSide: const BorderSide(
                              color: Colors.white, width: 0.0
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.white, width: 0.0
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.white, width: 0.0
                          ),
                        ),
                        hintText: r'''Password''',
                        hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                        contentPadding: EdgeInsets.only(left: 15),
                      ),
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: const Color(0xFFFFFFFF),
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
                          Utenti utente = new Utenti(nomeUtente: usernameController.toString(), password: passwordController.toString());
                          DatabaseHelper.istance.getPasswordVerified(usernameController.text).then((val) {
                            if (val == '[]') {
                              print("Utente inesistente, procedo a creare utente");
                              DatabaseHelper.istance.add(utente);
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PageLoginPage(),
                                ),
                              );
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
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PageRegisterPage(),
                                    ),
                                  );
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
                          });
                        },
                        child: Container(
                            width: double.maxFinite,
                            height: 40,
                            padding: EdgeInsets.only(top:7),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.05),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                border: Border.all(color: Colors.white, width: 2)
                            ),
                            child: Text(
                              '''Login''',
                              style: GoogleFonts.adventPro(
                                textStyle: TextStyle(
                                  color: const Color(0xFFFFFFFF),
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
      ),
    );
  }
}
