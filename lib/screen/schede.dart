import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/creaScheda.dart';
import 'package:mytraining/screen/login.dart';
import 'package:mytraining/screen/visualizzaScheda.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Schede extends StatefulWidget {
  static bool valoreOrologio = false;

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
                          if (!Schede.valoreOrologio) {
                            schedeModel.schedaBeingEdited = await SchedeDBworker
                                .schedeDBworker
                                .get(scheda.id);
                            print(schedeModel.schedaBeingEdited.nomeScheda);
                            schedeModel.setStackIndex(1);
                          } else {
                            print("C'E UN ALLENAMENTO IN CORSO");
                          }
                        },
                        onTap: () async {
                          if (!Schede.valoreOrologio) {
                            saveValueScheda(scheda.id);
                            print("Ciao bro " + scheda.id.toString());
                            await eserciziModel.loadData(
                                EserciziDBworker.eserciziDBworker, scheda.id);
                            schedeModel.setStackIndex(2);
                          } else {
                            print("C'E UN ALLENAMENTO IN CORSO");
                          }
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
                      schedeModel.schedaBeingEdited = Scheda();
                      print(schedeModel.schedaBeingEdited.nomeScheda);
                      schedeModel.setStackIndex(1);
                    },
                  )),
            ])),
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
            if (value == 0) {
              utentiModel.setStackIndex(3);
            } else if (value == 2) {
              LoginPage().getValueLogin().then((val) async {
                utentiModel.utenteBeingEdited =
                    await UtentiDBworker.utentiDBworker.get(val);
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
