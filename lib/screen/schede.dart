import 'dart:async';

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
import 'package:mytraining/screen/base.dart';
import 'package:mytraining/screen/creaScheda.dart';
import 'package:mytraining/screen/login.dart';
import 'package:mytraining/screen/visualizzaScheda.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/bottomNavigationBar.dart';

class Schede extends StatefulWidget {
  static bool valoreOrologio = false;
  static int schedaAllenamento = -2;
  static String nomeSchedaGLobal = "";
  static bool hoCaricatoleSchede = true;
  List<Registro> listaVoti = [];

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
                      left: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        "Ecco le tue Schede!",
                        //textAlign: TextAlign.center,
                        style: GoogleFonts.adventPro(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery.of(context).size.width * 0.07,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      )),
                  Spacer(),
                  Container(
                      margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.03,
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
                            print("Aaaaaaaaaaaaa "+schedeModel.schedaBeingEdited.nomeScheda);
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
              Visibility(
                visible: Schede.hoCaricatoleSchede,
                replacement: const CircularProgressIndicator(
                  color: Colors.white,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                            color: const Color.fromARGB(255, 42, 42, 42),
                            icon: Icons.delete,
                            onTap: () {
                              _deleteScheda(context, scheda);
                            },
                          ),
                        ],
                        child: GestureDetector(
                            onLongPress: () async {
                              schedeModel.schedaBeingEdited =
                                  await SchedeDBworker.schedeDBworker
                                      .get(scheda.id);
                              print(schedeModel.schedaBeingEdited.nomeScheda);
                              schedeModel.setStackIndex(1);
                            },
                            onTap: () async {
                              saveValueScheda(scheda.id);
                              print("OOOOOOOOOOOOOOOOOO " + scheda.nomeScheda);
                              Schede.schedaAllenamento = scheda.id;
                              Schede.nomeSchedaGLobal = scheda.nomeScheda;
                              setState(() {
                                VisualizzaScheda.hoCaricatoGliEs = false;
                              });
                              await eserciziModel.loadData(
                                  EserciziDBworker.eserciziDBworker, scheda.id);
                              await registriModel.loadData(
                                  RegistriDBworker.registriDBworker, scheda.id);
                              setState(() {
                                VisualizzaScheda.hoCaricatoGliEs = true;
                              });
                              schedeModel.setStackIndex(2);
                            },
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                padding: const EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 230, 245, 252),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    ),
                                    border: Border.all(color: Colors.white)),
                                child: Row(children: [
                                  const SizedBox(width: 10),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.10,
                                    width: MediaQuery.of(context).size.width *
                                        0.13,
                                    margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                      right: MediaQuery.of(context).size.width *
                                          0.05,
                                      left: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                        ),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: IconButton(
                                      icon: Icon(
                                        IconData(scheda.icona,
                                            fontFamily: 'MaterialIcons'),
                                      ),
                                      onPressed: () {},
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    scheda.nomeScheda,
                                    style: GoogleFonts.adventPro(
                                      textStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 42, 42, 42),
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.045,
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    height: 5,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Durata: " + scheda.durataScheda,
                                    style: GoogleFonts.adventPro(
                                      textStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 42, 42, 42),
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ]))),
                      ),
                    );
                  },
                ),
              ),
            ])),
        bottomNavigationBar: buildBottomNavigationBar(context, _currentIndex));
  }

  Future _deleteScheda(BuildContext context, Scheda scheda) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: setupAlertDialoadContainer(scheda),
          );
        });
  }

  Widget setupAlertDialoadContainer(Scheda scheda) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            border: Border.all(color: Colors.white)),
        height: MediaQuery.of(context).size.height *
            0.2, // Change as per your requirement
        width: MediaQuery.of(context).size.width *
            0.80, // Change as per your requirement
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Elimina Scheda",
                style: GoogleFonts.adventPro(
                  textStyle: TextStyle(
                    color: const Color.fromARGB(255, 42, 42, 42),
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Sei sicuro di voler eliminare " +
                    scheda.nomeScheda +
                    "? Perderai tutti i dati in essa contenuti",
                style: GoogleFonts.adventPro(
                  textStyle: TextStyle(
                    color: const Color.fromARGB(255, 42, 42, 42),
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    child: Text(
                      "Annulla",
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: const Color.fromARGB(255, 42, 42, 42),
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(),
                  ),
                  FlatButton(
                    child: Text(
                      "Conferma",
                      style: GoogleFonts.adventPro(
                        textStyle: TextStyle(
                          color: const Color.fromARGB(255, 42, 42, 42),
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await SchedeDBworker.schedeDBworker.delete(scheda.id);
                      Navigator.of(context).pop();
                      setState(() {
                        Schede.hoCaricatoleSchede = false;
                      });
                      LoginPage().getValueLogin().then((val) async {
                        await schedeModel.loadData(
                            SchedeDBworker.schedeDBworker, val);
                      });
                      setState(() {
                        Schede.hoCaricatoleSchede = true;
                      });
                      utentiModel.setStackIndex(4);
                      /*Timer(
                          const Duration(milliseconds: 0),
                          () => {
                                Base.pageIndexForWidget = 4,
                                utentiModel.setStackIndex(7),
                              }); */
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }

/*double calcolaStelleAlle(int id) {
    double tot = 0;
    updateList(id);
    print("Aggiorno e creo " + id.toString());
    for(Registro r in registriModel.registriList2){
      tot += (2*double.parse(r.voto)).floorToDouble()/2;
      print(id.toString() + " cd " +r.id.toString() + " ji " +tot.toString());
    }
    tot = tot/registriModel.registriList2.length;
    print(tot.toString());
    if(registriModel.registriList2.length > 0)
      registriModel.registriList2 = [];
    return tot;
  }

  Future<int> updateList(int id) async {
    await registriModel.loadData2(
        RegistriDBworker.registriDBworker, id);
    return 0;
  } */
}
