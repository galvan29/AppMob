import 'package:flutter/material.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/eventiDBworrker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/base.dart';
import 'package:mytraining/screen/login.dart';
import 'package:mytraining/models/eventiModel.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
                onPressed: (){
                  utentiModel.setStackIndex(3);
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
              ),
              child: Text(r'''Beta Tester: Christian Bolletta, Rebecca Giabardo, Tobia Giabardo, Anna Vaglieri''',
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
              child: Text(/*r'''Aiutanti: Christian Bolletta'''*/"",
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
              ),
              child: Text('',
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
          ],
        ),
      ),
    );
  }



}
