import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Schede extends StatefulWidget {
  @override
  State<Schede> createState() => _SchedeState();

  getValueScheda() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idScheda');
  }
}

class _SchedeState extends State<Schede> {
  final datasets = <String, dynamic>{};

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  int _currentIndex = 1;

  saveValueScheda(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('idScheda', id);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
          onPressed: () {
            schedeModel.schedaBeingEdited = Scheda();
            schedeModel.setStackIndex(1);
          },
        ), */
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
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
                      schedeModel.schedaBeingEdited =
                          await SchedeDBworker.schedeDBworker.get(scheda.id);
                      schedeModel.setStackIndex(1);
                    },
                    onTap: () async {
                      saveValueScheda(scheda.id);
                      print("Ciao bro " + scheda.id.toString());
                      await eserciziModel.loadData(
                          EserciziDBworker.eserciziDBworker, scheda.id);
                      schedeModel.setStackIndex(2);
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
                  schedeModel.setStackIndex(1);
                },
              )),
        ])),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: const Color.fromARGB(255, 180, 212, 250),
          selectedItemColor: Colors.white.withOpacity(0.5),
          unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
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
            content: Text(
                "Are you sure you want to delete ${scheda.nomeScheda}"),
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
                    await schedeModel.loadData(SchedeDBworker.schedeDBworker, val);
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
