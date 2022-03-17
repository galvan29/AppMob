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

  @override
  Widget build(BuildContext context) {
    String displayTime2 = "";
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
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
                                  color: Colors.black,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ElevatedButton(
                            onPressed: () async {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.start);
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ElevatedButton(
                            onPressed: () async {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.stop);
                            },
                            child: const Text(
                              'Pause',
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ElevatedButton(
                            onPressed: () async {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.reset);
                              Schede.valoreOrologio = false;
                              registriModel.registroBeingEdited = Registro();
                              registriModel.registroBeingEdited.durataFinale =
                                  displayTime2;
                              _save(context);
                              //schedeModel.setStackIndex(5);
                            },
                            child: const Text(
                              'Finish',
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
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: eserciziModel.eserciziList.length,
          itemBuilder: (BuildContext inBuildContext, int inIndex) {
            Esercizio esercizio = eserciziModel.eserciziList[inIndex];
            Color color = Colors.white;
            return Card(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              elevation: 8,
              child: Slidable(
                actionPane: const SlidableScrollActionPane(),
                actionExtentRatio: .25,
                child: ListTile(
                  title: Text(esercizio.nomeEsercizio),
                  subtitle: Text("Rip: " +
                      esercizio.ripEsercizio +
                      "\n Serie: " +
                      esercizio.serieEsercizio +
                      "\n Peso: " +
                      esercizio.pesoEsercizio +
                      "\n Note: " +
                      esercizio.noteEsercizio),
                  tileColor: color,
                  onTap: () {},
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
                child: const Text("Cancel"),
              ),
            ],
          )),
    );
  }

  void _save(BuildContext context) async {
    // if(registriModel.registroBeingEdited.id==-1){
    Schede().getValueScheda().then((val) async {
      registriModel.registroBeingEdited.idScheda = val.toString();
    });
    FineAllenamento.idTempRegistro = await RegistriDBworker.registriDBworker
        .create(registriModel.registroBeingEdited);
    print("Creato una nuova registro con id " +
        FineAllenamento.idTempRegistro.toString());
    // } else {
    // await RegistriDBworker.registriDBworker.update(registriModel.registroBeingEdited);
    // }

    Schede().getValueScheda().then((val) async {
      await registriModel.loadData(RegistriDBworker.registriDBworker, val);
    });

    //Base.pageIndexForWidget=12;
    schedeModel.setStackIndex(5);
//dd
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        content: Text("Scheda completata, ho salvato i dati della sessione"),
      ),
    );
  }
}
