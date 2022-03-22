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

  Future<int> loadData(dynamic inDatabaseWorker, int id) async {
    eserciziList = await inDatabaseWorker.getAll(id);
    notifyListeners();
    return 0;
  }
}

EserciziModel eserciziModel = EserciziModel();