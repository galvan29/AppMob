import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/registriDBworker.dart';
import 'package:mytraining/models/registriModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mytraining/screen/schede.dart';

class FineAllenamento extends StatelessWidget {
  final datasets = <String, dynamic>{};
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  static int idTempRegistro = 0;
  static String durataStringa = "";
  @override
  Widget build(BuildContext context) {
    double rat = 0;
    return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: const Color.fromARGB(255, 42, 42, 42),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Text(r'''Allenamento finito in:''',
                    style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 35,
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
                decoration: const BoxDecoration(),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Text(durataStringa,
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
                decoration: const BoxDecoration(),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Text('Come valuti il tuo allenamento?',
                    style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 35,
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
                decoration: const BoxDecoration(),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.10,
                ),
                alignment: Alignment.center,
                child:  RatingBar.builder(
                  initialRating: 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    rat = rating;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 30,
                  top: 50,
                  right: 30,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: GestureDetector(
                    onTap: () async {
                      registriModel.registroBeingEdited = await RegistriDBworker.registriDBworker.get(FineAllenamento.idTempRegistro);
                      registriModel.registroBeingEdited.voto = rat.toString();
                      registriModel.registroBeingEdited.giorno = DateTime.now().toString();
                      await RegistriDBworker.registriDBworker.update(registriModel.registroBeingEdited);
                      await registriModel.loadData(RegistriDBworker.registriDBworker, Schede.schedaAllenamento);
                      schedeModel.setStackIndex(0);
                    },
                    child: Container(
                        width: 10,
                        height: 50,
                        padding: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 180, 212, 250),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border: Border.all(color: Colors.white)),
                        child: Text(
                          '''Registra Risposta''',
                          style: GoogleFonts.adventPro(
                            textStyle: const TextStyle(
                              color:  Color.fromARGB(255, 230, 245, 252),
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
      ));
  }
}