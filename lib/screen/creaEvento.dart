import 'package:flutter/material.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/eventiDBworrker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/base.dart';
import 'package:mytraining/screen/homepage.dart';
import 'package:mytraining/screen/login.dart';
import 'package:mytraining/models/eventiModel.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
class CreaEvento extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static DateTime inidata = DateTime.now();

  static DateTime findata = DateTime.now();
  var txt = TextEditingController(),
      txt1 = TextEditingController();
  int selectedRadio = -1;
  var nomeScheda = TextEditingController();

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay.now();

  DateTime dateTime = DateTime.now();

  bool showDate = false;

  bool showTime = false;

  bool showDateTime = false;

  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      locale: const Locale("it", ""),
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
        selectedDate = selected;
    }
    return selectedDate;
  }

// Select for Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
        selectedTime = selected;
    }
    return selectedTime;
  }

  // select date time picker
  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    if (date == null) return;

    final time = await _selectTime(context);

    if (time == null) return;
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
  }

  DateTime getDateTime() {
    if (dateTime == null) {
      return DateTime.now();
    } else {
      return dateTime;
    }
  }

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
                top: MediaQuery.of(context).size.width * 0.08,
              ),
            ),
            SizedBox(
                width: 330,
                child: Text(
                  "Programma il tuo allenamento!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.007,
              ),
            ),
            SizedBox(
                width: 330,
                child: Text(
                  "Scegli la scheda tra quelle da te create, la data del tuo allenamento e la possibile durata.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.adventPro(
                    textStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  child: TextFormField(

                    style: GoogleFonts.adventPro(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    onTap: () {
                      _showDialog(context);
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                        labelText: "Nome Scheda",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                    validator: (String? inValue) {
                      if (inValue!.isEmpty) {
                        return "Scegli Scheda";
                      }
                      return null;
                    },
                    onChanged: (String inValue) {
                      eventiModel.eventoBeingEdited.nomeScheda = inValue;
                    },
                    controller: nomeScheda,
                  ),
                )),
            /*Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  child: TextFormField(
                    style: GoogleFonts.adventPro(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    validator: (String? inValue) {
                      if (inValue!.isEmpty) {
                        return "Scegli Data ed Orario ";
                      }
                      return null;
                    },
                    controller: txt,
                    decoration: const InputDecoration(
                        labelText: "Data inizio 1",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      DateTime? picked = await DatePicker.showDateTimePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(2022, 1, 1),
                          onConfirm: (date) {
                            inidata = date;
                            txt.text = inidata.toString();
                            txt1.text = "0";
                            eventiModel.eventoBeingEdited.inizio = inidata;
                            eventiModel.eventoBeingEdited.fine = inidata;
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.it);
                    },
                    onChanged: (String inValue) {
                      eventiModel.eventoBeingEdited.inizio = CreaEvento.inidata;
                    },
                  ),
                )),*/
            //test
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  child: TextFormField(
                    style: GoogleFonts.adventPro(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    validator: (String? inValue) {
                      if (inValue!.isEmpty) {
                        return "Scegli Data ed Orario";
                      }
                      return null;
                    },
                    controller: txt,
                    decoration: const InputDecoration(
                        labelText: "Data inizio",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await _selectDateTime(context);
                      showDateTime = true;
                      inidata = getDateTime();
                      txt.text = DateFormat('dd-MM-yyyy HH:mm').format(CreaEvento.inidata);
                      txt1.text = "0";
                      eventiModel.eventoBeingEdited.inizio = CreaEvento.inidata;
                      eventiModel.eventoBeingEdited.fine = CreaEvento.inidata;
                    },
                    onChanged: (String inValue) {
                      eventiModel.eventoBeingEdited.inizio = CreaEvento.inidata;
                      eventiModel.eventoBeingEdited.inizio = inidata;
                    },
                  ),
                )),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: SizedBox(
                      height: 70,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.25,
                      child: TextFormField(
                        //enabled: false,
                          decoration: const InputDecoration(
                              labelText: "Durata (m)",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                          style: GoogleFonts.adventPro(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).size.width * 0.045,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          controller: txt1,
                          onTap: () {
                            //double click
                            FocusScope.of(context)
                                .requestFocus(FocusNode());
                          }),
                    )),
                const Spacer(),
                Container(
                  margin: EdgeInsets.only(
                    right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.03,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white.withOpacity(0), width: 1.5),
                    color: Colors.white.withOpacity(0),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      icon: const Icon(Icons.remove),
                      color: Colors.white,
                      onPressed: () {
                        if (int.parse(txt1.text) > 0) {
                          DateTime a = eventiModel.eventoBeingEdited.fine
                              .add(const Duration(minutes: -15));
                          eventiModel.eventoBeingEdited.fine = a;
                          txt1.text = (a
                              .subtract(Duration(
                              milliseconds: eventiModel
                                  .eventoBeingEdited
                                  .inizio
                                  .millisecondsSinceEpoch))
                              .millisecondsSinceEpoch /
                              60000)
                              .toString()
                              .replaceAll(".0", "");
                        }
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.03,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black.withOpacity(0), width: 1.5),
                    color: Colors.black.withOpacity(0),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () {
                        DateTime a = eventiModel.eventoBeingEdited.fine
                            .add(const Duration(minutes: 15));
                        eventiModel.eventoBeingEdited.fine = a;
                        txt1.text = (a
                            .subtract(Duration(
                            milliseconds: eventiModel
                                .eventoBeingEdited
                                .inizio
                                .millisecondsSinceEpoch))
                            .millisecondsSinceEpoch /
                            60000)
                            .toString()
                            .replaceAll(".0", "");
                      }),
                ),
              ],
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
                    if (_formKey.currentState!.validate()) {
                      _save(context);
                      //txt.text = "";
                    }
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
                        'Aggiungi',
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
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(schedeModel.schedeList.length,
                        (int index) {
                      return ListTile(
                          title: Text(schedeModel.schedeList[index].nomeScheda),
                          leading: Radio<int>(
                            value: index,
                            groupValue: selectedRadio,
                            onChanged: (int? value) {
                              nomeScheda.text =
                                  schedeModel.schedeList[index].nomeScheda;
                              setState(() => selectedRadio = value!);
                              eventiModel.eventoBeingEdited.nomeScheda =
                                  schedeModel.schedeList[index].nomeScheda;
                              Navigator.of(context).pop();
                            },
                          ));
                    }),
              );
            },
          ),
        );
      },
    );
  }

  void _save(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    //_formKey.currentState.save();

    if (eventiModel.eventoBeingEdited.id == -1) {
      LoginPage().getValueLogin().then((val) async {
        eventiModel.eventoBeingEdited.idUtente = val.toString();
      });
      print(
          "Creando nuovo evento: " + eventiModel.eventoBeingEdited.nomeScheda);

      await EventiDBworker.eventiDBworker.create(eventiModel.eventoBeingEdited);
    } else {
      await EventiDBworker.eventiDBworker.update(eventiModel.eventoBeingEdited);
    }
    HomePage.hoCaricatoGliEventi = false;
    LoginPage().getValueLogin().then((val) async {
      await eventiModel.loadData(EventiDBworker.eventiDBworker, val);
    });

    HomePage.hoCaricatoGliEventi = true;
    Base.pageIndexForWidget = 3;
    utentiModel.setStackIndex(7);
    //utentiModel.setStackIndex(3);
  }
}
