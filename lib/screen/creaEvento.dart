import 'package:flutter/material.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/eventiDBworrker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/base.dart';
import 'package:mytraining/screen/login.dart';
import 'package:mytraining/models/eventiModel.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreaEvento extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static DateTime inidata = DateTime.now();
  static DateTime findata = DateTime.now();
  var txt = TextEditingController(), txt1 = TextEditingController();
  int selectedRadio = -1;
  var nomeScheda = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              FlatButton(
                onPressed: (){
                  utentiModel.setStackIndex(3);
                },
                child: Text("Indietro",
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.black,
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
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            const SizedBox(
                width: 330,
                child: Text(
                  "Programma un allenamento!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    onTap: (){
                      _showDialog(context);
                    },
                    readOnly: true,
                    decoration: const InputDecoration(labelText: "Nome Scheda"),
                    validator: (String? inValue) {
                      if (inValue!.isEmpty) {
                        return "Inserisci Nome";
                      }
                      return null;
                    },
                    onChanged: (String inValue) {
                      eventiModel.eventoBeingEdited.nomeScheda = inValue;
                    },
                    controller: nomeScheda,
                  ),)),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    controller: txt,
                    decoration: const InputDecoration(labelText: "Data inizio"),
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
                  ),)),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                      decoration: const InputDecoration(labelText: "Durata"),
                      controller: txt1,
                      onTap: () {
                        //double click
                        FocusScope.of(context).requestFocus(new FocusNode());
                        DateTime a = eventiModel.eventoBeingEdited.fine
                            .add(Duration(minutes: 30));
                        eventiModel.eventoBeingEdited.fine = a;
                        txt1.text = (a.subtract(Duration(milliseconds: eventiModel.eventoBeingEdited.inizio.millisecondsSinceEpoch)).millisecondsSinceEpoch/60000).toString().replaceAll(".0", "");
                      }),)),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 330,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            _save(context);
                          }
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    )))
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
                children: List<Widget>.generate(schedeModel.schedeList.length, (int index) {
                  return
                    ListTile(
                        title: Text(schedeModel.schedeList[index].nomeScheda),
                        leading: Radio<int>(
                    value: index,
                    groupValue: selectedRadio,
                    onChanged: (int? value) {
                      nomeScheda.text = schedeModel.schedeList[index].nomeScheda;
                      setState(() => selectedRadio = value!);
                      eventiModel.eventoBeingEdited.nomeScheda=schedeModel.schedeList[index].nomeScheda;
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

    LoginPage().getValueLogin().then((val) async {
      await eventiModel.loadData(EventiDBworker.eventiDBworker, val);
    });

    Base.pageIndexForWidget = 3;
    utentiModel.setStackIndex(7);


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        content: Text("Evento saved"),
      ),
    );
  }
}
