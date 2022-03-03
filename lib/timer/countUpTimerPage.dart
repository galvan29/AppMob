import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CountUpTimerPage extends StatefulWidget {
  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => CountUpTimerPage(),
      ),
    );
  }

  @override
  _State createState() => _State();
}

class _State extends State<CountUpTimerPage> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  final _scrollController = ScrollController();

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
            //iniziomerda
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  /// Display stop watch time
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: _stopWatchTimer.rawTime.value,
                      builder: (context, snap) {
                        final value = snap.data!;
                        final displayTime =
                        StopWatchTimer.getDisplayTime(value, hours: _isHours);
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                displayTime,
                                style: const TextStyle(
                                    fontSize: 40,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
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
                                child: RaisedButton(
                                  padding: const EdgeInsets.all(4),
                                  color: Colors.lightBlue,
                                  shape: const StadiumBorder(),
                                  onPressed: () async {
                                    _stopWatchTimer.onExecute
                                        .add(StopWatchExecute.start);
                                  },
                                  child: const Text(
                                    'Start',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: RaisedButton(
                                  padding: const EdgeInsets.all(4),
                                  color: Colors.green,
                                  shape: const StadiumBorder(),
                                  onPressed: () async {
                                    _stopWatchTimer.onExecute
                                        .add(StopWatchExecute.stop);
                                  },
                                  child: const Text(
                                    'Stop',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: RaisedButton(
                                  padding: const EdgeInsets.all(4),
                                  color: Colors.red,
                                  shape: const StadiumBorder(),
                                  onPressed: () async {
                                    _stopWatchTimer.onExecute
                                        .add(StopWatchExecute.reset);
                                  },
                                  child: const Text(
                                    'Reset',
                                    style: TextStyle(color: Colors.white),
                                  ),
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



          ],
        ),
      ),
      body: ListView.builder(
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
              secondaryActions: [
                IconSlideAction(
                  caption: "Delete",
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    //_deleteEsercizio(context, esercizio);
                  },
                ),
              ],
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
                onLongPress: () async {
                  eserciziModel.esercizioBeingEdited = await EserciziDBworker
                      .eserciziDBworker
                      .get(esercizio.id);
                  schedeModel.setStackIndex(3);
                },
                onTap: () {},
              ),
            ),
          );
        },
      ),


     /*body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// Display stop watch time
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snap) {
                  final value = snap.data!;
                  final displayTime =
                  StopWatchTimer.getDisplayTime(value, hours: _isHours);
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          displayTime,
                          style: const TextStyle(
                              fontSize: 40,
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
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
                          child: RaisedButton(
                            padding: const EdgeInsets.all(4),
                            color: Colors.lightBlue,
                            shape: const StadiumBorder(),
                            onPressed: () async {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.start);
                            },
                            child: const Text(
                              'Start',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: RaisedButton(
                            padding: const EdgeInsets.all(4),
                            color: Colors.green,
                            shape: const StadiumBorder(),
                            onPressed: () async {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.stop);
                            },
                            child: const Text(
                              'Stop',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: RaisedButton(
                            padding: const EdgeInsets.all(4),
                            color: Colors.red,
                            shape: const StadiumBorder(),
                            onPressed: () async {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.reset);
                            },
                            child: const Text(
                              'Reset',
                              style: TextStyle(color: Colors.white),
                            ),
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
      ),*/
    );
  }
}