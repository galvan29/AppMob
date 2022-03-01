import 'package:flutter/material.dart';

class Scheda {
  int id = -1;
  String nomeScheda = "";
  String durataScheda = "";
}

class SchedeModel extends ChangeNotifier {
  int stackIndex = 0;
  List schedeList = [];
  Scheda schedaBeingEdited = Scheda();
  String nomeScheda = "";
  String durataScheda = "";

  void setStackIndex(int inStackIndex){
    stackIndex = inStackIndex;
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

  void loadData(dynamic inDatabaseWorker) async {
    schedeList = await inDatabaseWorker.getAll();
    notifyListeners();
  }

}

SchedeModel schedeModel = SchedeModel();