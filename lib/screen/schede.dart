import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/registriDBworker.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:mytraining/models/registriModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/creaScheda.dart';
import 'package:mytraining/screen/login.dart';
import 'package:mytraining/screen/visualizzaScheda.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/bottomNavigationBar.dart';

class Schede extends StatefulWidget {
  static bool valoreOrologio = false;
  static int schedaAllenamento = -2;

  @override
  State<Schede> createState() => _SchedeState();

  getValueScheda() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idScheda');
  }
}

class _SchedeState extends State<Schede> {
  final datasets = <String, dynamic>{};

  int _currentIndex = 1;

  saveValueScheda(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('idScheda', id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: const Color.fromARGB(255, 42, 42, 42),
        floatingActionButton: Visibility(
          visible: Schede.valoreOrologio,
          child: FloatingActionButton(
            onPressed: () {
              schedeModel.setStackIndex(4);
            },
            child: const Icon(Icons.play_arrow, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
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
                  child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  SizedBox(
                      width: 330,
                      child: Text(
                        "Ecco le tue Schede!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 30,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      )),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          icon: const Icon(Icons.add),
                          color: Colors.black,
                          onPressed: () {
                            // if (!Schede.valoreOrologio) {
                            schedeModel.schedaBeingEdited = Scheda();
                            print(schedeModel.schedaBeingEdited.nomeScheda);
                            schedeModel.setStackIndex(1);
                            //  }else{
                            //  print("Non puoi perchè c0è un allenamento in corso");
                            //}
                          })),
                ],
              )),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: schedeModel.schedeList.length,
                itemBuilder: (BuildContext inBuildContext, int inIndex) {
                  Scheda scheda = schedeModel.schedeList[inIndex];
                  Color color = Colors.white;

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
                            onTap: () {
                              _deleteScheda(context, scheda);
                            },
                          ),
                        ],
                        child: GestureDetector(
                          onLongPress: () async {
                            schedeModel.schedaBeingEdited = await SchedeDBworker
                                .schedeDBworker
                                .get(scheda.id);
                            print(schedeModel.schedaBeingEdited.nomeScheda);
                            schedeModel.setStackIndex(1);
                          },
                          onTap: () async {
                            saveValueScheda(scheda.id);
                            Schede.schedaAllenamento = scheda.id;
                            print("Ciao bro " + scheda.id.toString());
                            await eserciziModel.loadData(
                                EserciziDBworker.eserciziDBworker, scheda.id);
                            await registriModel.loadData(
                                RegistriDBworker.registriDBworker, scheda.id);
                            schedeModel.setStackIndex(2);
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              padding: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 230, 245, 252),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  border: Border.all(color: Colors.white)),
                              child: Column(children: [
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      scheda.nomeScheda,
                                      style: GoogleFonts.adventPro(
                                        textStyle: TextStyle(
                                          color:
                                          const Color.fromARGB(255, 42, 42, 42),
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.045,
                                          fontStyle: FontStyle.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10, height: 5,),
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      "Durata: " + scheda.durataScheda,
                                      style: GoogleFonts.adventPro(
                                        textStyle: TextStyle(
                                          color:
                                          const Color.fromARGB(255, 42, 42, 42),
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                          fontStyle: FontStyle.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ])),
                        ),
                      ));
                },
              ),
            ])),
        bottomNavigationBar: buildBottomNavigationBar(context, _currentIndex));
  }

  Future _deleteScheda(BuildContext context, Scheda scheda) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext) {
          return AlertDialog(
            title: const Text("Elinina Scheda"),
            content: Text(
                "Sei sicuro di voler eliminare ${scheda.nomeScheda}? Perderai tutti i dati in essa contenuti"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(inAlertContext).pop();
                },
                child: const Text("Indietro"),
              ),
              FlatButton(
                onPressed: () async {
                  await SchedeDBworker.schedeDBworker.delete(scheda.id);
                  Navigator.of(inAlertContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      content: Text("Scheda Eliminata!"),
                    ),
                  );
                  LoginPage().getValueLogin().then((val) async {
                    await schedeModel.loadData(
                        SchedeDBworker.schedeDBworker, val);
                  });
                  schedeModel.setStackIndex(0);
                },
                child: const Text("Elimina"),
              ),
            ],
          );
        });
  }
}
