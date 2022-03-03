import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/screen/allenamento.dart';
import 'package:mytraining/screen/schede.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';


class VisualizzaScheda extends StatelessWidget {
  final datasets = <String, dynamic>{};
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

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
        /*floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: (){
            eserciziModel.esercizioBeingEdited = Esercizio();
            schedeModel.setStackIndex(3);
            print("Creazione Esercizio");
          },
        ),*/
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.play_arrow, color: Colors.white),
          onPressed: () {
            schedeModel.setStackIndex(4);
          },
        ),
        body: ListView.builder(
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
                    eserciziModel.esercizioBeingEdited = await EserciziDBworker
                        .eserciziDBworker
                        .get(esercizio.id);
                    schedeModel.setStackIndex(3);
                  },
                  onTap: () {},
                ),
              ),
            );
          },
        ),
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

