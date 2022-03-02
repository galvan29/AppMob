import 'package:flutter/material.dart';

class Esercizio {
  int id = -1;
  String nomeEsercizio = "";
  String idScheda = "";
  String ripEsercizio = "";
  String serieEsercizio = "";
  String pesoEsercizio = "";
  String noteEsercizio = "";
}

class EserciziModel extends ChangeNotifier {
  List eserciziList = [];
  Esercizio esercizioBeingEdited = Esercizio();
  String nomeEsercizio = "";
  String idScheda = "";
  String ripEsercizio = "";
  String serieEsercizio = "";
  String pesoEsercizio = "";
  String noteEsercizio = "";

  void setNomeEsercizio(String nomeEsercizio2){
    nomeEsercizio = nomeEsercizio2;
    notifyListeners();
  }

  void setSerieEsercizio(String ripEsercizio2){
    ripEsercizio = ripEsercizio2;
    notifyListeners();
  }

  void setRipEsercizio(String serieEsercizio2){
    serieEsercizio = serieEsercizio2;
    notifyListeners();
  }

  void setPesoEsercizio(String pesoEsercizio2){
    pesoEsercizio = pesoEsercizio2;
    notifyListeners();
  }

  void setNoteEsercizio(String noteEsercizio2){
    noteEsercizio = noteEsercizio2;
    notifyListeners();
  }


  Future<int> loadData(dynamic inDatabaseWorker, int id) async {
    eserciziList = await inDatabaseWorker.getAll(id);
    notifyListeners();
    return 0;
  }

}

EserciziModel eserciziModel = EserciziModel();