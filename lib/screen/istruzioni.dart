import 'package:flutter/material.dart';
import 'package:mytraining/common/appbarInfo.dart';
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
                  utentiModel.setStackIndex(3);
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
              child: Text(r'''Istruzioni''',
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
                left: 8,
                right : 8
              ),
              child: Text(r'''Per eliminare una Scheda/Esercizio/Allenamento è necessario spostare verso sinistra l'elemento in questione, e comparirà il simbolo Elimina che permetterà di eliminare l'elemento desiderato.

Per modificare una Scheda/Esercizio è necessario tenere premuto l'elemento scelto ed effettuare la modifica scelta tramite form.

Durante l'allenamento, tramite il tasto in basso a destra, è possibile far partire un secondo timer che permette di effettuare una pausa senza fermare il timer principale.

Durante l'allenamento è possibile utilizzare l'applicazione in tutte le schermate, tuttavia non è possibile iniziare un secondo allenamento. Per riprendere l'allenamento in corso comprarirà un pulsante in basso a destra che permetterà di riprendere l'allenamento.
''',
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 20),
            ),
            /*Container(
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
              child: Text(
                  r'''Beta Tester: Christian Bolletta, Rebecca Giabardo, Tobia Giabardo, Anna Vaglieri''',
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
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
