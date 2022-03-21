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

class Info extends StatelessWidget {
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
      backgroundColor: const Color.fromARGB(255, 42, 42, 42),
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
            Container(
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              decoration: const BoxDecoration(),
              child: Text(r'''Informazioni''',
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 40,
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
              alignment: Alignment.center,
              decoration: const BoxDecoration(),
              margin: const EdgeInsets.only(
                top: 20,
              ),
              child: Text(r'''Creatori: Matteo Galvan & Diletta Giabardo''',
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 2),
            ),
            Container(
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: const BoxDecoration(),
              margin: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(r'''Beta Tester:''',
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 2),
            ),
            Container(
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: const BoxDecoration(),
              margin: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(r'''Aiutanti: Christian Bolletta''',
                  style: GoogleFonts.adventPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 2),
            ),
            Container(
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: const BoxDecoration(),
              margin: const EdgeInsets.only(
                top: 10,
              ),
              child: Text('',
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
                  maxLines: 2),
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
        backgroundColor:  Color.fromARGB(255, 230, 220, 245),
        duration: Duration(seconds: 2),
        content: Text("Allenamento Programmato!"),
      ),
    );
  }
}
