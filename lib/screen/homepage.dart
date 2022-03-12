import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/eventiDBworrker.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/eventiModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/login.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:mytraining/screen/notification_api.dart';

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
    setState(() {
    });
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: Colors.white,
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
                        color: Colors.black,
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
                        color: Colors.black,
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
                            color: const Color.fromARGB(255, 253, 237, 210),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border: Border.all(color: Colors.white)),
                        child: Text(
                          '''Scheda''',
                          style: GoogleFonts.adventPro(
                            textStyle: const TextStyle(
                              color: Color(0xFF000000),
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
                        color: Colors.black,
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
                height: 400,
                decoration: const BoxDecoration(
                  color: const Color.fromARGB(255, 209, 251, 234),
                ),
                child: SfCalendar(
                    view: CalendarView.month,
                    dataSource: MeetingDataSource(getMeetingData()),
                    monthViewSettings: const MonthViewSettings(
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.appointment),
                    onTap: (CalendarTapDetails details) async {
                      DateTime date = details.date!;
                      dynamic appointments = details.appointments;
                      String alle = "";
                      String giorno = DateFormat('dd-MM-yy').format(date);
                      if(appointments.length != 0){
                        for(var app in appointments){
                          alle += app.eventName+"  "+ DateFormat('HH.mm').format(app.from) + "\n";
                        }
                       _showDialog(context, alle, giorno);
                      }
                      LoginPage().getValueLogin().then((val) async {
                        await eventiModel.loadData(
                            EventiDBworker.eventiDBworker, val);
                      });
                    }),
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
                    onTap: () async {
                      eventiModel.eventoBeingEdited = Evento();
                      utentiModel.setStackIndex(6);
                    },
                    child: Container(
                        width: 10,
                        height: 50,
                        padding: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 209, 251, 234),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border: Border.all(color: Colors.white)),
                        child: Text(
                          '''Programma Allenamento''',
                          style: GoogleFonts.adventPro(
                            textStyle: const TextStyle(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ))),
              ),
              //scritta suggerimento
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Text(r'''Parametri''',
                    style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1),
              ),
              /*Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.07,
                          top: MediaQuery.of(context).size.width * 0.05,
                        ),
                        width: MediaQuery.of(context).size.width * 0.20,
                        height: 100,
                        padding: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 253, 237, 210),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border: Border.all(color: Colors.white)),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info,
                              size: MediaQuery.of(context).size.height * 0.07,
                              color: const Color(0xFF000000),
                            ),
                            Text(
                              '''70cm''',
                              style: GoogleFonts.adventPro(
                                textStyle: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.05,
                        ),
                        width: MediaQuery.of(context).size.width * 0.20,
                        height: 100,
                        padding: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 253, 237, 210),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border: Border.all(color: Colors.white)),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info,
                              size: MediaQuery.of(context).size.height * 0.07,
                              color: const Color(0xFF000000),
                            ),
                            Text(
                              '''10cm''',
                              style: GoogleFonts.adventPro(
                                textStyle: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.07,
                          top: MediaQuery.of(context).size.width * 0.05,
                        ),
                        width: MediaQuery.of(context).size.width * 0.20,
                        height: 100,
                        padding: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 253, 237, 210),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border: Border.all(color: Colors.white)),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info,
                              size: MediaQuery.of(context).size.height * 0.07,
                              color: const Color(0xFF000000),
                            ),
                            Text(
                              '''20cm''',
                              style: GoogleFonts.adventPro(
                                textStyle: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                  ],
                ),
              ),*/
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Text(r'''Suggerimento del Giorno''',
                    style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        color: Colors.black,
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
                padding: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                child: Text(
                    r'''Bere almeno due litri di acqua al giorno aiuta il corpo a rimanere idratato ed a mantenerlo in salute.''',
                    style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: const Color.fromARGB(255, 226, 213, 254),
          selectedItemColor: Colors.white.withOpacity(0.5),
          unselectedItemColor: Colors.black,
          selectedFontSize: MediaQuery.of(context).size.height * 0.02,
          unselectedFontSize: MediaQuery.of(context).size.height * 0.02,
          onTap: (value) {
            setState(() => _currentIndex = value);
            if (value == 1) {
              utentiModel.setStackIndex(4);
            } else if (value == 2) {
              LoginPage().getValueLogin().then((val) async {
                utentiModel.utenteBeingEdited =
                    await UtentiDBworker.utentiDBworker.get(val);
                print("Mio nome utente: " +
                    utentiModel.utenteBeingEdited.nomeUtente);
              });
              utentiModel.setStackIndex(5);
            }
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Homepage',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Schede',
              icon: Icon(Icons.article_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Profilo',
              icon: Icon(Icons.perm_identity_sharp),
            ),
          ],
        ));
  }

  void _showDialog(BuildContext context, String nomeApp, String giorno) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Allenamenti del "+giorno),
          content: Text(nomeApp),
          actions: <Widget>[
            FlatButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

List<Meeting> getMeetingData() {
  final List<Meeting> listMeetings = <Meeting>[];
  print("Ma entra qua");
  for (Evento eve in eventiModel.eventiList) {
    listMeetings.add(Meeting(eve.nomeScheda, eve.inizio, eve.fine));
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
}

class Meeting {
  Meeting(this.eventName, this.from, this.to);

  String eventName;
  DateTime from;
  DateTime to;

  @override
  String toString() {
    return 'Meeting{eventName: $eventName, from: $from, to: $to}';
  }
}
