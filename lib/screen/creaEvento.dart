import 'package:flutter/material.dart';
import 'package:mytraining/db/eventiDBworrker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/login.dart';
import 'package:mytraining/models/eventiModel.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreaEvento extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static DateTime inidata = DateTime.now();
  static DateTime findata = DateTime.now();
  var txt = TextEditingController(), txt1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                                border:
                                    Border.all(color: Colors.black, width: 1)),
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
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              FlatButton(
                onPressed: () {
                  utentiModel.setStackIndex(3);
                },
                child: const Text("Cancel"),
              ),
              const Spacer(),
              FlatButton(
                onPressed: () {
                  _save(context);
                },
                child: const Text("Save"),
              ),
            ],
          )),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                decoration: const InputDecoration(hintText: "Nome Scheda"),
                initialValue: eventiModel.eventoBeingEdited == null
                    ? null
                    : eventiModel.eventoBeingEdited.nomeScheda,
                validator: (String? inValue) {
                  if (inValue!.isEmpty) {
                    return "Inserisci Nome";
                  }
                  return null;
                },
                onChanged: (String inValue) {
                  eventiModel.eventoBeingEdited.nomeScheda = inValue;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                controller: txt,
                decoration: const InputDecoration(hintText: "Data inizio"),
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  DateTime? picked = await DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2022, 1, 1), onConfirm: (date) {
                    inidata = date;
                    txt.text = inidata.toString();
                    txt1.text = "0";
                    eventiModel.eventoBeingEdited.inizio = inidata;
                    eventiModel.eventoBeingEdited.fine = inidata;
                  }, currentTime: DateTime.now(), locale: LocaleType.it);
                },
                onChanged: (String inValue) {
                  eventiModel.eventoBeingEdited.inizio = inidata;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                  decoration: const InputDecoration(hintText: "Durata"),
                  controller: txt1,
                  onTap: () {
                    //double click
                    FocusScope.of(context).requestFocus(new FocusNode());
                    DateTime a = eventiModel.eventoBeingEdited.fine
                        .add(Duration(minutes: 15));
                    eventiModel.eventoBeingEdited.fine = a;
                    txt1.text = (a.subtract(Duration(milliseconds: eventiModel.eventoBeingEdited.inizio.millisecondsSinceEpoch)).millisecondsSinceEpoch/60000).toString().replaceAll(".0", "");
                  }),
              //creare due pulsanti
            ),
          ],
        ),
      ),
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

    LoginPage().getValueLogin().then((val) async {
      await eventiModel.loadData(EventiDBworker.eventiDBworker, val);
    });

    utentiModel.setStackIndex(3);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        content: Text("Evento saved"),
      ),
    );
  }
}
