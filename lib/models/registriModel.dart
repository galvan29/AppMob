import 'package:flutter/material.dart';

class Registro {
  int id = -1;
  String idScheda = "";
  String durataFinale = "";
  String voto = "";
}

class RegistriModel extends ChangeNotifier {
  List registriList = [];
  Registro registroBeingEdited = Registro();
  String idScheda = "";
  String durataFinale = "";
  String voto = "";

  Future<int> loadData(dynamic inDatabaseWorker, int id) async {
    registriList = await inDatabaseWorker.getAll(id);
    notifyListeners();
    return 0;
  }

}

RegistriModel registriModel = RegistriModel();