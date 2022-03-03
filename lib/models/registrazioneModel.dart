import 'package:flutter/material.dart';

class Registrazione {
  int id = -1;
  String idUtente = "";
  String nomeUtente = "";
  String PasswordUtente = "";
  String Nome = "";
  String Cognome = "";
  String Eta = "";
}

class RegistrazioneModel extends ChangeNotifier {
  int stackIndex = 0;
  List eventiList = [];
  Registrazione regBeingEdited = Registrazione();
  String idUtente = "";
  String nomeUtente = "";
  String PasswordUtente = "";
  String Nome = "";
  String Cognome = "";
  String Eta = "";

  void setIdRegistrazione(String idUtente2){
    idUtente = idUtente2;
    notifyListeners();
  }

  void setNomeRegistrazione(String nomeScheda2){
    nomeUtente = nomeScheda2;
    notifyListeners();
  }

  /*Future<int> getNomeSchedaEvento(){
    //get();
    notifyListeners();
    return 1;
  } */

  Future<int> loadData(dynamic inDatabaseWorker, int id) async {
    eventiList = await inDatabaseWorker.getAll(id);
    notifyListeners();
    return 0;
  }

}

RegistrazioneModel registrazioneModel = RegistrazioneModel();