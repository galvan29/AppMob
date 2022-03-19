import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:mytraining/models/registriModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/screen/allenamento.dart';
import 'package:mytraining/screen/schede.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class VisualizzaScheda extends StatelessWidget {
  final datasets = <String, dynamic>{};
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  bool checkNumber() {
    if (eserciziModel.eserciziList.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        /*floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: (){
            eserciziModel.esercizioBeingEdited = Esercizio();
            schedeModel.setStackIndex(3);
            print("Creazione Esercizio");
          },
        ),*/
        floatingActionButton: Visibility(
          visible: checkNumber() && !Schede.valoreOrologio, // Set it to false
          child: FloatingActionButton(
            child: const Icon(Icons.play_arrow, color: Colors.white),
            onPressed: () async {
              Schede.valoreOrologio = true;
              schedeModel.setStackIndex(4);
            },
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
              const SizedBox(
                  width: 330,
                  child: Text(
                    "Ecco la tua Scheda!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
                            _deleteEsercizio(context, esercizio);
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
                          eserciziModel.esercizioBeingEdited =
                              await EserciziDBworker.eserciziDBworker
                                  .get(esercizio.id);
                          schedeModel.setStackIndex(3);
                        },
                        onTap: () {},
                      ),
                    ),
                  );
                },
              ),
              Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.05,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    color: Colors.black,
                    onPressed: () {
                      eserciziModel.esercizioBeingEdited = Esercizio();
                      schedeModel.setStackIndex(3);
                    },
                  )),
              Container(
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  height: 400,
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
                  child: SingleChildScrollView(
                    //child: Row(
                    //children: [
                    child: Container(
                      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                      height: 400,
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Text("qui ci va il grafico"),
                    ),
                    /* ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: registriModel.registriList.length,
                        itemBuilder:
                            (BuildContext inBuildContext, int inIndex) {
                          Registro registro =
                              registriModel.registriList[inIndex];
                          Color color = Colors.white;

                          return Card(
                            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            elevation: 8,
                            child: Slidable(
                              actionPane: const SlidableScrollActionPane(),
                              actionExtentRatio: .25,
                              child: ListTile(
                                title: Text(registro.durataFinale),
                                subtitle: Text("Voto: " +
                                    registro.voto +
                                    " in data " +
                                    registro.giorno),
                                tileColor: color,
                              ),
                            ),
                          );
                        },
                      ),*/
                    //  ],
                  ))
              //),
            ])),
        //va in alto magari
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Row(
              children: [
                FlatButton(
                  onPressed: () {
                    schedeModel.setStackIndex(0);
                  },
                  child: const Text("Indietro"),
                ),
                const Spacer(),
                /* FlatButton(
                onPressed: (){
                  //_save(context);
                  schedeModel.setStackIndex(0);
                },
                child: const Text("Visionato"),
              ), */
              ],
            )));
  }

  Future _deleteEsercizio(BuildContext context, Esercizio esercizio) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext) {
          return AlertDialog(
            title: const Text("Delete note"),
            content: Text(
                "Are you sure you want to delete ${esercizio.noteEsercizio}"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(inAlertContext).pop();
                },
                child: const Text("Cancel"),
              ),
              FlatButton(
                onPressed: () async {
                  await EserciziDBworker.eserciziDBworker.delete(esercizio.id);
                  Navigator.of(inAlertContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      content: Text("Esercizio deleted"),
                    ),
                  );
                  Schede().getValueScheda().then((val) async {
                    eserciziModel.loadData(
                        EserciziDBworker.eserciziDBworker, val);
                  });
                  schedeModel.setStackIndex(0);
                },
                child: const Text("Delete"),
              ),
            ],
          );
        });
  }
}
