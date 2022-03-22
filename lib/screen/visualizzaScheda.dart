import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/chart/chartStr.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/eserciziDBworker.dart';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:mytraining/models/registriModel.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/screen/base.dart';
import 'package:mytraining/screen/schede.dart';

//import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

class VisualizzaScheda extends StatefulWidget {
  @override
  State<VisualizzaScheda> createState() => _VisualizzaSchedaState();
}

class _VisualizzaSchedaState extends State<VisualizzaScheda> {
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
    final List<ChartRegistri> dataR = [];
    for (Registro a in registriModel.registriList) {
      dataR.add(ChartRegistri(
          giorno: DateTime.parse(a.giorno),
          durata: fromDateToMinute(a.durataFinale),
          voto: a.voto));
    }
    /*dataR.add(ChartRegistri(
        giorno: DateTime.parse("2022-03-20"),
        durata: 120));
    dataR.add(ChartRegistri(
        giorno: DateTime.parse("2022-03-21"),
        durata: 124));*/

    /*  List<charts.Series<ChartRegistri, DateTime>> series = [
      charts.Series(
        id: 'Sales',
        data: dataR,
        domainFn: (ChartRegistri sales, _) => sales.giorno,
        measureFn: (ChartRegistri sales, _) => sales.durata,
      )
    ];  */

    return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: const Color.fromARGB(255, 42, 42, 42),
        floatingActionButton: Visibility(
          visible: checkNumber() && !Schede.valoreOrologio, // Set it to false
          child: FloatingActionButton(
            child: const Icon(Icons.play_arrow, color: Colors.white),
            onPressed: () async {
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
                        "Ecco la tua Scheda!",
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
                          eserciziModel.esercizioBeingEdited = Esercizio();
                          schedeModel.setStackIndex(3);
                        },
                      )),
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
                itemCount: eserciziModel.eserciziList.length,
                itemBuilder: (BuildContext inBuildContext, int inIndex) {
                  Esercizio esercizio = eserciziModel.eserciziList[inIndex];
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
                              _deleteEsercizio(context, esercizio);
                            },
                          ),
                        ],
                        child: GestureDetector(
                            onLongPress: () async {
                              eserciziModel.esercizioBeingEdited =
                                  await EserciziDBworker.eserciziDBworker
                                      .get(esercizio.id);
                              schedeModel.setStackIndex(3);
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
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 10),
                                      Text(
                                        esercizio.nomeEsercizio,
                                        style: GoogleFonts.adventPro(
                                          textStyle: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 42, 42, 42),
                                            fontWeight: FontWeight.w500,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.045,
                                            fontStyle: FontStyle.normal,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25),
                                      Text(
                                        "Rip: " + esercizio.ripEsercizio,
                                        style: GoogleFonts.adventPro(
                                          textStyle: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 42, 42, 42),
                                            fontWeight: FontWeight.w500,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            fontStyle: FontStyle.normal,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Serie: " + esercizio.serieEsercizio,
                                        style: GoogleFonts.adventPro(
                                          textStyle: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 42, 42, 42),
                                            fontWeight: FontWeight.w500,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            fontStyle: FontStyle.normal,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Peso: " + esercizio.pesoEsercizio,
                                        style: GoogleFonts.adventPro(
                                          textStyle: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 42, 42, 42),
                                            fontWeight: FontWeight.w500,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            fontStyle: FontStyle.normal,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                        height: 5,
                                      ),
                                      Text(
                                        "Note: " + esercizio.noteEsercizio,
                                        style: GoogleFonts.adventPro(
                                          textStyle: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 42, 42, 42),
                                            fontWeight: FontWeight.w500,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            fontStyle: FontStyle.normal,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ))),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05,
                ),
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Text('Registro Allenamenti',
                    style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1),
              ),
              Visibility(
                visible: registriModel.registriList.length > 0 ? true : false,
                child: Container(
                    margin: EdgeInsets.only(
                        top: 10, left: 30, right: 30, bottom: 40),
                    height: 330,
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
                          margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                          height: 300,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: SfCartesianChart(
                              enableAxisAnimation: true,
                              primaryXAxis: DateTimeAxis(),
                              series: <CartesianSeries>[
                                LineSeries<ChartRegistri, DateTime>(
                                    dataSource: dataR,
                                    xValueMapper: (ChartRegistri reg, _) =>
                                        reg.giorno,
                                    yValueMapper: (ChartRegistri reg, _) =>
                                        reg.durata,
                                    dataLabelMapper: (ChartRegistri reg, _) =>
                                        reg.voto,
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true))
                              ])
                          /*charts.TimeSeriesChart(
                          series,
                          animate: true,
                          dateTimeFactory: const charts.LocalDateTimeFactory(),
                          selectionModels: [
                            charts.SelectionModelConfig(
                                changedListener: (charts.SelectionModel model) {
                              if (model.hasDatumSelection) {
                                model.selectedSeries[0].measureFn(model.selectedDatum[0].index);
                              }
                            })
                          ],
                        )*/
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
                    )),
              ),
              Visibility(
                visible: registriModel.registriList.length > 0 ? false : true,
                    child: Container(
                        margin: const EdgeInsets.only(
                          left: 30,
                          top: 20,
                          right: 30,
                        ),
                        padding: EdgeInsets.zero,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(2.5, 3, 2.5, 5),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 230, 245, 252)
                                    .withOpacity(0),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                border: Border.all(color: Colors.white)),
                            child: Text(
                              "Per visualizzare le statistiche devi prima effettuare un allenamento",
                              style: GoogleFonts.adventPro(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ))),
                  ),
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
                  child: Text(
                    "Indietro",
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
            )));
  }

  Future _deleteEsercizio(BuildContext context, Esercizio esercizio) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: setupAlertDialoadContainer(esercizio),
          );
        });
  }

  Widget setupAlertDialoadContainer(Esercizio esercizio) {
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
        height: 180.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Elimina Esercizio",
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
              Text(
                "Sei sicuro di voler eliminare " +
                    esercizio.nomeEsercizio +
                    "? Perderai tutti i dati in esso contenuti",
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
              Row(
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
                      await EserciziDBworker.eserciziDBworker
                          .delete(esercizio.id);
                      Schede().getValueScheda().then((val) async {
                        eserciziModel.loadData(
                            EserciziDBworker.eserciziDBworker, val);
                      });
                      Navigator.of(context).pop();
                      Timer(
                          const Duration(milliseconds: 200),
                          () => {
                                Base.pageIndexForWidget = 2,
                                schedeModel.setStackIndex(6),
                              });
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }

  int fromDateToMinute(String durataFinale) {
    var parsedDate = DateTime.parse('2022-03-20 ' + durataFinale);
    return parsedDate.minute + parsedDate.hour * 60;
  }
}
