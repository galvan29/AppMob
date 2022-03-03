import 'package:flutter/material.dart';

class Evento {
  int id = -1;
  String idUtente = "";
  String nomeScheda = "";
  DateTime inizio = DateTime.now();
  DateTime fine = DateTime.now();
}

class EventiModel extends ChangeNotifier {
  List eventiList = [];
  Evento eventoBeingEdited = Evento();
  String idUtente = "";
  String nomeScheda = "";
  DateTime inizio = DateTime.now();
  DateTime fine = DateTime.now();

  void setIdScheda(String idUtente2){
    idUtente = idUtente2;
    notifyListeners();
  }

  void setNomeScheda(String nomeScheda2){
    nomeScheda = nomeScheda2;
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

  @override
  String toString() {
    return 'EventiModel{eventiList: $eventiList, eventoBeingEdited: $eventoBeingEdited, idUtente: $idUtente, nomeScheda: $nomeScheda, inizio: $inizio, fine: $fine}';
  }
}

EventiModel eventiModel = EventiModel();