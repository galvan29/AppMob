import 'package:flutter/material.dart';

class Scheda {
  int id = -1;
  int icona = 0;
  String idUtente = "";
  String nomeScheda = "";
  String durataScheda = "";
}

class SchedeModel extends ChangeNotifier {
  int stackIndex = 0;
  List schedeList = [];
  Scheda schedaBeingEdited = Scheda();
  int icona = 0;
  String idUtente = "";
  String nomeScheda = "";
  String durataScheda = "";

  void setStackIndex(int inStackIndex){
    stackIndex = inStackIndex;
    notifyListeners();
  }

  void setIdScheda(String idUtente2){
    idUtente = idUtente2;
    notifyListeners();
  }

  void setNomeScheda(String nomeScheda2){
    nomeScheda = nomeScheda2;
    notifyListeners();
  }

  void setDurataScheda(String durataScheda2){
    durataScheda = durataScheda2;
    notifyListeners();
  }

  Future<int> loadData(dynamic inDatabaseWorker, int id) async {
    schedeList = await inDatabaseWorker.getAll(id);
    notifyListeners();
    return 0;
  }
}

SchedeModel schedeModel = SchedeModel();