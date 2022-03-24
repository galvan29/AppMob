import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/registriDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:mytraining/models/registriModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/base.dart';
import 'package:mytraining/screen/fineAllenamento.dart';
import 'package:mytraining/screen/schede.dart';
import 'package:mytraining/screen/visualizzaScheda.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Allenamento extends StatefulWidget {
  @override
  State<Allenamento> createState() => _AllenamentoState();
}

class _AllenamentoState extends State<Allenamento> {
  final datasets = <String, dynamic>{};
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  bool isRunning = false;
  bool firstTime = false;
  @override
  Widget build(BuildContext context) {
    String displayTime2 = "";
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: const Color.fromARGB(255, 42, 42, 42),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.25),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: _stopWatchTimer.rawTime.value,
                  builder: (context, snap) {
                    final value = snap.data!;
                    final displayTime =
                        StopWatchTimer.getDisplayTime(value, hours: _isHours);
                    displayTime2 = displayTime;
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(displayTime,
                              style: GoogleFonts.adventPro(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 40,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                ),
                              )),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            /// Display stop watch time

            /// Button
            Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Visibility(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                onPressed: () async {
                                  Schede.valoreOrologio = true;
                                  _stopWatchTimer.onExecute
                                      .add(StopWatchExecute.start);
                                  setState(() {
                                    isRunning = true;
                                    firstTime = true;
                                  });
                                },
                                child: const Text(
                                  'Start',
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    textStyle: GoogleFonts.adventPro(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                              ),
                            ),
                            visible: !isRunning),
                        Visibility(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                onPressed: () async {
                                  _stopWatchTimer.onExecute
                                      .add(StopWatchExecute.stop);
                                  setState(() {
                                    isRunning = false;
                                  });
                                },
                                child: const Text(
                                  'Pausa',
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    textStyle: GoogleFonts.adventPro(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                              ),
                            ),
                            visible: isRunning),
                        Visibility(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                onPressed: () {
                                  mostraPopUpFine(context, displayTime2);
                                  //schedeModel.setStackIndex(5);
                                },
                                child: const Text(
                                  'Fine',
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    textStyle: GoogleFonts.adventPro(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                              ),
                            ),
                            visible: firstTime),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 15),
        Container(
          child: Text(
            "Esercizi",
            style: GoogleFonts.adventPro(
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: eserciziModel.eserciziList.length,
          itemBuilder: (BuildContext inBuildContext, int inIndex) {
            Esercizio esercizio = eserciziModel.eserciziList[inIndex];
            Color color = Colors.white;
            return Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
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
                child: Column(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text(
                          esercizio.nomeEsercizio,
                          style: GoogleFonts.adventPro(
                            textStyle: TextStyle(
                              color: const Color.fromARGB(255, 42, 42, 42),
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25),
                        Text(
                          "Rip: " + esercizio.ripEsercizio,
                          style: GoogleFonts.adventPro(
                            textStyle: TextStyle(
                              color: const Color.fromARGB(255, 42, 42, 42),
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Serie: " + esercizio.serieEsercizio,
                          style: GoogleFonts.adventPro(
                            textStyle: TextStyle(
                              color: const Color.fromARGB(255, 42, 42, 42),
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Peso: " + esercizio.pesoEsercizio,
                          style: GoogleFonts.adventPro(
                            textStyle: TextStyle(
                              color: const Color.fromARGB(255, 42, 42, 42),
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                          height: 5,
                        ),
                        Text(
                          "Note: " + esercizio.noteEsercizio,
                          style: GoogleFonts.adventPro(
                            textStyle: TextStyle(
                              color: const Color.fromARGB(255, 42, 42, 42),
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ])),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              FlatButton(
                onPressed: () {
                  schedeModel.setStackIndex(0);
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
    );
  }

  void _save(BuildContext context) async {
    // if(registriModel.registroBeingEdited.id==-1){
    registriModel.registroBeingEdited.idScheda =
        Schede.schedaAllenamento.toString();
    FineAllenamento.idTempRegistro = await RegistriDBworker.registriDBworker
        .create(registriModel.registroBeingEdited);
    print("Creato una nuova registro con id " +
        FineAllenamento.durataStringa.toString());
    // } else {
    // await RegistriDBworker.registriDBworker.update(registriModel.registroBeingEdited);
    // }
    await registriModel.loadData(
        RegistriDBworker.registriDBworker, Schede.schedaAllenamento);

    //Base.pageIndexForWidget=12;
    schedeModel.setStackIndex(5);
//dd
  }

  setupAlertDialoadContainer(String displayTime2) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            border: Border.all(color: Colors.white)),
        height: 180.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Termina allenamento",
                style: GoogleFonts.adventPro(
                  textStyle: TextStyle(
                    color: const Color.fromARGB(255, 42, 42, 42),
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Sei sicuro di voler terminare l'allenamento?",
                style: GoogleFonts.adventPro(
                  textStyle: TextStyle(
                    color: const Color.fromARGB(255, 42, 42, 42),
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    child: Text(
                      "Annulla",
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: const Color.fromARGB(255, 42, 42, 42),
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(),
                  ),
                  FlatButton(
                    child: Text(
                      "Conferma",
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: const Color.fromARGB(255, 42, 42, 42),
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      _stopWatchTimer.onExecute
                          .add(StopWatchExecute.reset);
                      Schede.valoreOrologio = false;
                      registriModel.registroBeingEdited =
                          Registro();
                      registriModel.registroBeingEdited
                          .durataFinale = displayTime2;
                      FineAllenamento.durataStringa = displayTime2;
                      setState(() {
                        firstTime = false;
                        isRunning = false;
                      });
                      _save(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void mostraPopUpFine(BuildContext context, String displayTime2) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: setupAlertDialoadContainer(displayTime2),
          );
        });
  }
}
