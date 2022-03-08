import 'package:flutter/material.dart';

class Utente {
  int id = -1;
  String nomeUtente = "";
  String password = "";
  String nome = "";
  String cognome = "";
  String eta = "";
  String height = "";
  String weight = "";
}

class UtentiModel extends ChangeNotifier {
  int stackIndex = 0;
  List utenteList = [];
  Utente utenteBeingEdited = Utente();
  String nomeUtente = "";
  String password = "";
  String nome = "";
  String cognome = "";
  String eta = "";
  String height = "";
  String weight = "";
  Utente up = Utente();

  void setStackIndex(int inStackIndex){
    stackIndex = inStackIndex;
    notifyListeners();
  }

  void setNomeUtente(String nomeUtente2){
    nomeUtente = nomeUtente2;
    notifyListeners();
  }

  void setUtentePassword(String password2){
    password = password2;
    notifyListeners();
  }

  Future<int> getPassword(dynamic inDatabaseWorker, String nomeUtente) async {
    up = await inDatabaseWorker.getPassword(nomeUtente);
    notifyListeners();
    return 1;
  }

  Future<int> getIdFromNomeUtente(dynamic inDatabaseWorker, String nomeUtente) async {
    up = await inDatabaseWorker.getId(nomeUtente);
    notifyListeners();
    return 1;
  }

  void loadData(dynamic inDatabaseWorker) async {
    utenteList = await inDatabaseWorker.getAll();
    notifyListeners();
  }

}

UtentiModel utentiModel = UtentiModel();