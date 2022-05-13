import 'package:flutter/material.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/models/utentiModel.dart';


class Info extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static DateTime inidata = DateTime.now();
  static DateTime findata = DateTime.now();
  var txt = TextEditingController(), txt1 = TextEditingController();
  int selectedRadio = -1;
  var nomeScheda = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: const Color.fromARGB(255, 42, 42, 42),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              FlatButton(
                onPressed: () {
                  utentiModel.setStackIndex(8);
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
            Container(
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              decoration: const BoxDecoration(),
              child: Text(r'''Informazioni''',
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 40,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1),
            ),
            Container(
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: const BoxDecoration(),
              margin: const EdgeInsets.only(
                top: 20,
              ),
              child: Text(r'''Creatori: Matteo Galvan & Diletta Giabardo''',
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 2),
            ),
            Container(
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: const BoxDecoration(),
              margin: const EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10
              ),
              child: Text(
                  r'''Beta Tester: Christian, Alice, Alessia, Francesco, Luca, Simone''',
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2),
            ),
            Container(
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: const BoxDecoration(),
              margin: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(/*r'''Aiutanti: Christian Bolletta'''*/ "",
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 2),
            ),
            Container(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              decoration: const BoxDecoration(),
              margin: const EdgeInsets.only(
                top: 10,
              ),
              child: Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Image.asset(
                  'assets/image/logoGym.png',
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
