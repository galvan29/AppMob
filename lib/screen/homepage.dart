import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/common/appbarIstru.dart';
import 'package:mytraining/db/eventiDBworrker.dart';
import 'package:mytraining/models/eventiModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/login.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:mytraining/common/bottomNavigationBar.dart';

var list = [
  'La migliore preparazione per domani è fare il tuo meglio oggi. (H. Jackson Brown Jr.)',
  'Cerco sempre di fare ciò che non sono capace di fare, per imparare come farlo. (Pablo Picasso)',
  'Esiste un’isola di opportunità all’interno di ogni difficoltà. (Anonimo)',
  'Gli ostacoli sono quelle cose spaventose che vediamo ogni qualvolta distogliamo lo sguardo dalla nostra meta. (Anonimo)',
  'Le sfide sono ciò che rendono la vita interessante… Superarle è ciò che le dà siginificato. (Joshua J. Marine)',
  'Sbagli il 100% dei colpi che non spari. (Wayne Gretzky)',
  'Se puoi sognarlo, puoi farlo. (Walt Disney)',
  'Non arrenderti. Rischieresti di farlo un’ora prima del miracolo. (Proverbio arabo)',
  'Il primo passo che devi fare se vuoi essere una persona di successo è decidere che tipo di persona vuoi essere. Esistono 3 tipi di persone: coloro che fanno accadere le cose; coloro che guardano accadere le cose e coloro che si meravigliano di ciò che accade. (John M. Capozzi)',
  'Non avrai mai fallito finché continuerai a provare. (Anonimo)',
  'Tra vent’anni non sarete delusi delle cose che avete fatto ma da quelle che non avete fatto. Allora levate l’ancora,abbandonate i porti sicuri, catturate il vento nelle vostre vele. Esplorate. Sognate. Scoprite. (Mark Twain)',
  'Non aver paura di lottare per ciò in cui credi, anche se questo significa lottare da solo. (Anonimo)',
  'Piccole opportunità sono spesso l’inizio di grandi imprese. (Demostene)'
];
final _random = new Random();
var element = list[_random.nextInt(list.length)];

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
  static bool hoCaricatoGliEventi = true;
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
              /*Container(
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
              ),*/
              Container(
                margin: const EdgeInsets.only(
                    left: 30, top: 15, right: 30, bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 3, 15, 5),
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
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    textAlign: TextAlign.center),
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
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1),
              ),
              //calendario
              Visibility(
                visible: HomePage.hoCaricatoGliEventi,
                replacement: Container(
                  margin: const EdgeInsets.only(
                      left: 100, top: 160, right: 100, bottom: 160),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 30,
                    top: 10,
                    right: 30,
                  ),
                  padding: EdgeInsets.zero,
                  width: double.maxFinite,
                  height: 350,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 42, 42, 42),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    border: Border.all(color: Colors.white),
                  ),
                  child: SfCalendar(
                      view: CalendarView.month,
                      cellBorderColor: Colors.blue.withOpacity(0),
                      dataSource: MeetingDataSource(getMeetingData()),
                      todayHighlightColor: Colors.white.withOpacity(0.5),
                      headerStyle: CalendarHeaderStyle(
                          textStyle: TextStyle(color: Colors.white)),
                      selectionDecoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        shape: BoxShape.rectangle,
                      ),
                      monthViewSettings:  MonthViewSettings(
                          monthCellStyle: MonthCellStyle(
                              textStyle: TextStyle(color: Colors.white),
                              leadingDatesTextStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                        trailingDatesTextStyle: TextStyle( color: Colors.white.withOpacity(0.2)),),
                          agendaStyle: AgendaStyle(
                            dayTextStyle: TextStyle(color: Colors.white)),

                          appointmentDisplayMode:
                              MonthAppointmentDisplayMode.appointment),

                      viewHeaderStyle: ViewHeaderStyle(
                          dayTextStyle:
                          TextStyle(color: Colors.white.withOpacity(0.6))),
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
                                DateFormat('HH.mm').format(app.from) +
                                " di " +
                                app.durata +" min";
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
              ),
              Visibility(
                visible: schedeModel.schedeList.isNotEmpty ? true : false,
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
                              color: const Color.fromARGB(255, 230, 245, 252).withOpacity(0.6),
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
                visible: schedeModel.schedeList.isNotEmpty ? false : true,
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
                        padding: const EdgeInsets.fromLTRB(2.5, 3, 2.5, 5),
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
              /*Container(
                margin: EdgeInsets.only(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02,
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
              ),*/
              //suggerimento
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
    var height_size = MediaQuery.of(context).size.height * 0.2;
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
        // Change as per your requirement
        width: MediaQuery.of(context).size.width * 0.80,
        height: height_size + (idEve.length - 1) * height_size * 0.44 >
                height_size * 1.55
            ? height_size * 1.55
            : height_size + (idEve.length - 1) * height_size * 0.44,
        // Change as per your requirement// Change as per your requirement
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
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
                physics: const NeverScrollableScrollPhysics(),
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
                            color: Colors.white.withOpacity(0),
                            icon: Icons.delete,
                            onTap: () async {
                              Evento ev =
                                  await EventiDBworker.eventiDBworker.get(id);
                              Navigator.of(context).pop();
                              _deleteEvento(context, ev);
                            },
                          ),
                        ],
                        child: Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.07,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              border: Border.all(color: Colors.black)),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Text(
                                str,
                                style: GoogleFonts.adventPro(
                                  textStyle: TextStyle(
                                    color:
                                    const Color.fromARGB(255, 42, 42, 42),
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width *
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
              TextButton(
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
        height: MediaQuery.of(context).size.height *
            0.2, // Change as per your requirement
        width: MediaQuery.of(context).size.width *
            0.80, // Change as per your requirement
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
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
              const SizedBox(
                height: 20,
              ),
              Text(
                "Sei sicuro di voler eliminare l'evento per la scheda " +
                    ev.nomeScheda +
                    "?",
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
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
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
                  TextButton(
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
                      // Navigator.of(context).pop();
                      setState(() {
                        HomePage.hoCaricatoGliEventi = false;
                      });
                      LoginPage().getValueLogin().then((val) async {
                        await eventiModel.loadData(
                            EventiDBworker.eventiDBworker, val);
                      });
                      Navigator.of(context).pop();
                      Timer(Duration(milliseconds: 300), () {
                        setState(() {
                          HomePage.hoCaricatoGliEventi = true;
                        });
                      });
                      /*Timer(
                          const Duration(milliseconds: 160),
                              () => {
                            Base.pageIndexForWidget = 3,
                            utentiModel.setStackIndex(7),
                          });*/
                      utentiModel.setStackIndex(3);
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
  LoginPage().getValueLogin().then((val) async {
    await eventiModel.loadData(EventiDBworker.eventiDBworker, val);
  });
  for (Evento eve in eventiModel.eventiList) {
    listMeetings.add(Meeting(eve.nomeScheda, eve.inizio, eve.fine, eve.id,
        Colors.white.withOpacity(0.5), eve.fine.difference(eve.inizio).inMinutes.toString()));
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

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }

  @override
  String getDurata(int index) {
    return appointments![index].durata;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.id, this.color, this.durata);

  String eventName;
  DateTime from;
  DateTime to;
  int id;
  Color color;
  String durata;

  @override
  String toString() {
    return 'Meeting{eventName: $eventName, from: $from, to: $to, id: $id}';
  }
}
