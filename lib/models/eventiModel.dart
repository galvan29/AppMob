import 'package:flutter/material.dart';

class Evento {
  int id = -1;
  String idUtente = "";
  String nomeScheda = "";
  String durataScheda = "";
}

class EventiModel extends ChangeNotifier {
  int stackIndex = 0;
  List eventiList = [];
  Evento eventoBeingEdited = Evento();
  String idUtente = "";
  String nomeScheda = "";
  String durataScheda = "";

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
    eventiList = await inDatabaseWorker.getAll(id);
    notifyListeners();
    return 0;
  }

}

EventiModel eventiModel = EventiModel();