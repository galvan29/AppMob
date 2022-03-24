import 'package:flutter/material.dart';
import 'package:mytraining/screen/schede.dart';

class Registro {
  int id = -1;
  String idScheda = "";
  String giorno = "";
  String durataFinale = "";
  String voto = "";
}

class RegistriModel extends ChangeNotifier {
  List registriList = [];
  List registriList2 = [];
  Registro registroBeingEdited = Registro();
  String idScheda = "";
  String giorno = "";
  String durataFinale = "";
  String voto = "";

  Future<int> loadData(dynamic inDatabaseWorker, int id) async {
    registriList = await inDatabaseWorker.getAll(id);
    notifyListeners();
    return 0;
  }

  Future<int> loadData2(dynamic inDatabaseWorker, int id) async {
    registriList2 = await inDatabaseWorker.getAll(id);
    return 0;
  }

}

RegistriModel registriModel = RegistriModel();