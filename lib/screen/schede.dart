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
              const SizedBox(
                  width: 330,
                  child: Text(
                    "Scegli la tua Scheda",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
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
                itemCount: schedeModel.schedeList.length,
                itemBuilder: (BuildContext inBuildContext, int inIndex) {
                  Scheda scheda = schedeModel.schedeList[inIndex];
                  Color color = Colors.white;

                  return Card(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    elevation: 8,
                    color: Colors.blue,
                    child: Slidable(
                      actionPane: const SlidableScrollActionPane(),
                      actionExtentRatio: .25,
                      secondaryActions: [
                        IconSlideAction(
                          caption: "Delete",
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            _deleteScheda(context, scheda);
                          },
                        ),
                      ],
                      child: ListTile(
                        title: Text(scheda.nomeScheda),
                        subtitle: Text(scheda.durataScheda),
                        tileColor: color,
                        onLongPress: () async {
                          //if (!Schede.valoreOrologio) {
                            schedeModel.schedaBeingEdited = await SchedeDBworker
                                .schedeDBworker
                                .get(scheda.id);
                            print(schedeModel.schedaBeingEdited.nomeScheda);
                            schedeModel.setStackIndex(1);
                        //  } else {
                         //   print("C'E UN ALLENAMENTO IN CORSO");
                        //  }
                        },
                        onTap: () async {
                          //if (!Schede.valoreOrologio) {
                            saveValueScheda(scheda.id);
                            Schede.schedaAllenamento = scheda.id;
                            print("Ciao bro " + scheda.id.toString());
                            await eserciziModel.loadData(
                                EserciziDBworker.eserciziDBworker, scheda.id);
                            await registriModel.loadData(
                                RegistriDBworker.registriDBworker, scheda.id);
                            schedeModel.setStackIndex(2);
                         // } else {
                         //   print("C'E UN ALLENAMENTO IN CORSO");
                          //}
                        },
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
                     // if (!Schede.valoreOrologio) {
                        schedeModel.schedaBeingEdited = Scheda();
                        print(schedeModel.schedaBeingEdited.nomeScheda);
                        schedeModel.setStackIndex(1);
                    //  }else{
                      //  print("Non puoi perchè c0è un allenamento in corso");
                      //}
                    }
                  )),
            ])),
        bottomNavigationBar: buildBottomNavigationBar(context, _currentIndex));
  }

  Future _deleteScheda(BuildContext context, Scheda scheda) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext) {
          return AlertDialog(
            title: const Text("Delete Scheda"),
            content:
                Text("Are you sure you want to delete ${scheda.nomeScheda}"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(inAlertContext).pop();
                },
                child: const Text("Cancel"),
              ),
              FlatButton(
                onPressed: () async {
                  await SchedeDBworker.schedeDBworker.delete(scheda.id);
                  Navigator.of(inAlertContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      content: Text("Esercizio deleted"),
                    ),
                  );
                  LoginPage().getValueLogin().then((val) async {
                    await schedeModel.loadData(
                        SchedeDBworker.schedeDBworker, val);
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
