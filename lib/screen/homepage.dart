import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/common/appbarHome.dart';
import 'package:mytraining/db/eventiDBworrker.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/eventiModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/base.dart';
import 'package:mytraining/screen/login.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:mytraining/common/bottomNavigationBar.dart';

var list = [
  'Chi vuol star sano, viver molti anni, mangi broccoli, broccoli e gnoccoli, e danzi senza zoccoli.',
  'Mai affrettarti. Fai un sacco di esercizio fisico. Sii sempre allegro. Prendi tutto il sonno di cui hai bisogno. E puoi aspettarti di stare bene.',
  'Ho deciso di essere felice perché fa bene alla mia salute.',
  'Mi sveglio sempre in forma e mi deformo attraverso gli altri.',
  'Se volete la vitamina C o il beta-carotene, non ricorrete al flacone nell’armadietto dei medicinali, ma al cestino della frutta o alla verdura verde in foglia.',
  'La vera ricchezza non sta nel possedere oggetti d’oro o d’argento, ma nella salute.',
  'Prenditi cura del tuo corpo. È l’unico posto in cui devi vivere.',
  'Mangiare nel modo giusto non solo previene la malattia, ma genera anche la salute e un senso di benessere fisico e mentale.'
];
final _random = new Random();
var element = list[_random.nextInt(list.length)];

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final datasets = <String, dynamic>{};

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  //Homepage
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                child: Text(r'''BENVENUTO!''',
                    style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        color: Colors.white,
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
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Text(r'''E' ora di fare un po' di esercizi''',
                    style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        color: Colors.white,
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
                  left: 30,
                  top: 20,
                  right: 30,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: GestureDetector(
                    onTap: () {
                      utentiModel.setStackIndex(4);
                    },
                    child: Container(
                        width: 10,
                        height: 50,
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
                        child: Text(
                          '''Scheda''',
                          style: GoogleFonts.adventPro(
                            textStyle: const TextStyle(
                              color: const Color.fromARGB(255, 42, 42, 42),
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ))),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Text(r'''Calendario''',
                    style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1),
              ),
              //calendario
              Container(
                margin: const EdgeInsets.only(
                  left: 30,
                  top: 10,
                  right: 30,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                height: 350,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 230, 220, 245),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: SfCalendar(
                    view: CalendarView.month,
                    cellBorderColor: Colors.blue.withOpacity(0),
                    dataSource: MeetingDataSource(getMeetingData()),
                    monthViewSettings: const MonthViewSettings(
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.appointment),
                    onTap: (CalendarTapDetails details) async {
                      DateTime date = details.date!;
                      dynamic appointments = details.appointments;
                      String alle = "";
                      List<String> text = [];
                      List<int> idEve = [];
                      String giorno = DateFormat('dd-MM-yy').format(date);
                      if (appointments.length != 0) {
                        for (var app in appointments) {
                          alle += app.eventName +
                              " alle " +
                              DateFormat('HH.mm').format(app.from);
                          idEve.add(app.id);
                          text.add(alle);
                          print("Dario " + alle);
                          alle = "";
                        }
                        _showDialog(context, text, idEve, giorno);
                      }
                      LoginPage().getValueLogin().then((val) async {
                        await eventiModel.loadData(
                            EventiDBworker.eventiDBworker, val);
                      });
                    }),
              ),
              Visibility(
                visible: schedeModel.schedeList.length > 0 ? true : false,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 30,
                    top: 20,
                    right: 30,
                  ),
                  padding: EdgeInsets.zero,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(),
                  child: GestureDetector(
                      onTap: () async {
                        eventiModel.eventoBeingEdited = Evento();
                        utentiModel.setStackIndex(6);
                      },
                      child: Container(
                          height: 50,
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
                          child: Text(
                            '''Programma Allenamento''',
                            style: GoogleFonts.adventPro(
                              textStyle: const TextStyle(
                                color: const Color.fromARGB(255, 42, 42, 42),
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ))),
                ),
              ),
              Visibility(
                visible: schedeModel.schedeList.length > 0 ? false : true,
                child: Container(
                    margin: const EdgeInsets.only(
                      left: 30,
                      top: 20,
                      right: 30,
                    ),
                    padding: EdgeInsets.zero,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(),
                    child: Container(
                        padding: EdgeInsets.fromLTRB(2.5, 3, 2.5, 5),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 230, 245, 252)
                                .withOpacity(0),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            border: Border.all(color: Colors.white)),
                        child: Text(
                          "Per programmare un allenamento è necessario prima creare almeno una scheda",
                          style: GoogleFonts.adventPro(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ))),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Text(r'''Suggerimento Utile''',
                    style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1),
              ),
              //suggerimento
              Container(
                margin: const EdgeInsets.only(
                  left: 30,
                  top: 20,
                  right: 30,
                  bottom: 70,
                ),
                padding: EdgeInsets.fromLTRB(2.5, 3, 2.5, 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0),
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Text(element,
                    style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 10),
              ),
            ],
          ),
        ),
        bottomNavigationBar: buildBottomNavigationBar(context, _currentIndex));
  }

  void _showDialog(
      BuildContext context, List<String> text, List<int> idEve, String giorno) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: setupAlertDialoadContainer(text, idEve, giorno),
        );
      },
    );
  }

  Widget setupAlertDialoadContainer(
      List<String> text, List<int> idEve, String giorno) {
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
        height: 180.0 + (idEve.length - 1) * 80 > 280
            ? 280
            : 180.0 + (idEve.length - 1) * 80, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Allenamenti del " + giorno,
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: text.length,
                itemBuilder: (BuildContext inBuildContext, int inIndex) {
                  String str = text[inIndex];
                  int id = idEve[inIndex];
                  return Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Slidable(
                        actionPane: const SlidableScrollActionPane(),
                        actionExtentRatio: .25,
                        secondaryActions: [
                          IconSlideAction(
                            caption: "Elimina",
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () async {
                              Evento ev =
                                  await EventiDBworker.eventiDBworker.get(id);
                              _deleteEvento(context, ev);
                            },
                          ),
                        ],
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 230, 245, 252),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              border: Border.all(color: Colors.white)),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text(
                                str,
                                style: GoogleFonts.adventPro(
                                  textStyle: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 42, 42, 42),
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  );
                },
              ),
              FlatButton(
                child: Text(
                  "OK",
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
            ],
          ),
        ));
  }

  Widget setupAlertDialoadContainer2(Evento ev) {
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
                "Elimina Evento",
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
                "Sei sicuro di voler eliminare l'evento per la scheda "+ev.nomeScheda+"?",
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
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.28,
                    ),
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
                      await EventiDBworker.eventiDBworker.delete(ev.id);
                      LoginPage().getValueLogin().then((val) async {
                        await eventiModel.loadData(
                            EventiDBworker.eventiDBworker, val);
                      });
                      Navigator.of(context).pop();
                      Timer(
                          const Duration(milliseconds: 160),
                              () => {
                            Base.pageIndexForWidget = 3,
                            utentiModel.setStackIndex(7),
                          });
                    },
                  ),
                ],
              )

            ],
          ),
        ));
  }

  Future _deleteEvento(BuildContext context, Evento ev) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: setupAlertDialoadContainer2(ev),
          );
        });
  }
}

List<Meeting> getMeetingData() {
  final List<Meeting> listMeetings = <Meeting>[];
  print("Ma entra qua");
  for (Evento eve in eventiModel.eventiList) {
    listMeetings.add(Meeting(eve.nomeScheda, eve.inizio, eve.fine, eve.id));
  }
  print(listMeetings.length);

  //listMeetings.add(Meeting('Meeting 1', startDateTime1, endDateTime1));
  //final DateTime startDateTime2 = DateTime(2021, 9, 8, 12, 0, 0);
  //final DateTime endDateTime2 = startDateTime1.add(const Duration(hours: 3));
  return listMeetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> listMeetings) {
    appointments = listMeetings;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  int getId(int index) {
    return appointments![index].id;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.id);

  String eventName;
  DateTime from;
  DateTime to;
  int id;

  @override
  String toString() {
    return 'Meeting{eventName: $eventName, from: $from, to: $to, id: $id}';
  }
}
