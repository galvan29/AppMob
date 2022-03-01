import 'package:flutter/material.dart';

class Utente {
  int id = -1;
  String nomeUtente = "";
  String password = "";
}

class UtentiModel extends ChangeNotifier {
  int stackIndex = 0;
  List utenteList = [];
  Utente utenteBeingEdited = Utente();
  String nomeUtente = "";
  String password = "";

  void setStackIndex(int inStackIndex){
    stackIndex = inStackIndex;
    notifyListeners();
  }

  void setnomeUtente(String nomeUtente2){
    nomeUtente = nomeUtente2;
    notifyListeners();
  }

  void setUtentePassword(String password2){
    password = password2;
    notifyListeners();
  }

  void loadData(dynamic inDatabaseWorker) async {
    utenteList = await inDatabaseWorker.getAll();
    notifyListeners();
  }

}

UtentiModel utentiModel = UtentiModel();