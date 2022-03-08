import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/db/eventiDBworrker.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/eventiModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/login.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mytraining/screen/notification_api.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
          Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
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
                              fontSize:
                              MediaQuery.of(context).size.height * 0.03,
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
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              child: Icon(
                                Icons.info,
                                size: MediaQuery.of(context).size.height * 0.02,
                                color: const Color(0xFF000000),
                              )),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
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
                            color: const Color.fromARGB(255, 180, 212, 250),
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
                margin: const EdgeInsets.only(
                  left: 30,
                  top: 10,
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
                            color: const Color.fromARGB(255, 180, 212, 250),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border: Border.all(color: Colors.white)),
                        child: Text(
                          '''Inizia Allenamento''',
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
              //calendario
              Container(
                margin: const EdgeInsets.only(
                  left: 30,
                  top: 20,
                  right: 30,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                height: 400,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 180, 212, 250),
                ),
                child: SfCalendar(
                    view: CalendarView.month,
                    dataSource: MeetingDataSource(getMeetingData()),
                    monthViewSettings: const MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
                    onTap: (CalendarTapDetails details) async {
                      //DateTime date = details.date!;
                      dynamic appointments = details.appointments;
                      //CalendarElement view = details.targetElement;
                      //print("Creati i due eventi");
                      //getMeetingData();
                      //print(appointments[0]);
                      LoginPage().getValueLogin().then((val) async {
                        await eventiModel.loadData(EventiDBworker.eventiDBworker, val);
                      });
                    }
                ),
              ),
              GestureDetector(
                child: Container(
                    child: const Text("PremiCoddue per creare nuovo evento")
                ),
                onTap: () async {
                  eventiModel.eventoBeingEdited = Evento();
                  utentiModel.setStackIndex(6);
                },
              ),
              //scritta suggerimento
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
                    onTap: () => NotificationApi.showNotification(
                      title: 'Notifica',
                      body: 'Schifo',
                      payload: 'notifica',
                  ),
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
                          '''Notifica''',
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


              //cronometro
              /*Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                        padding: const EdgeInsets.all(4),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        CountUpTimerPage.navigatorPush(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Go To CountUpTimer',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  /* Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                        padding: const EdgeInsets.all(4),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        CountDownTimerPage.navigatorPush(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Go To CountDownTimer',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ), */
                ],
              ),*/
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: const Color.fromARGB(255, 180, 212, 250),
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
                print("Mio nome utente: "+utentiModel.utenteBeingEdited.nomeUtente);
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
}

List<Meeting> getMeetingData() {
  final List<Meeting> listMeetings = <Meeting>[];
  print("Ma entra qua");
  for(Evento eve in eventiModel.eventiList){
    listMeetings.add(Meeting(eve.nomeScheda, eve.inizio, eve.fine));
  }
  print(listMeetings.length);

  //listMeetings.add(Meeting('Meeting 1', startDateTime1, endDateTime1));
  //final DateTime startDateTime2 = DateTime(2021, 9, 8, 12, 0, 0);
  //final DateTime endDateTime2 = startDateTime1.add(const Duration(hours: 3));
  return listMeetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> listMeetings){
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

