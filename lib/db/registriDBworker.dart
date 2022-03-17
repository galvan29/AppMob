import 'dart:io';

import 'package:mytraining/models/registriModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class RegistriDBworker {

  RegistriDBworker._();
  static final RegistriDBworker registriDBworker = RegistriDBworker._();

  Database? _db;

  Future<Database?> _getDB() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    if(_db==null){
      print("Sto creando il database registri");
      String path = join(docsDir.path, "registri.db");
      _db = await openDatabase(path, version: 1,
          onCreate: (Database inDB, int inVersion) async {
            await inDB.execute("CREATE TABLE IF NOT EXISTS registri ("
                "id INTEGER PRIMARY KEY,"
                "idScheda TEXT,"
                "durataFinale TEXT,"
                "voto TEXT)");
          });
    }
    return _db;
  }

  Registro registroFromMap(Map inMap){
    Registro registro = Registro();
    registro.id = inMap["id"];
    registro.idScheda = inMap["idScheda"];
    registro.durataFinale = inMap["durataFinale"];
    registro.voto = inMap["voto"];
    return registro;
  }

  Map<String, dynamic> registroToMap(Registro registro) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = registro.id;
    map["idScheda"] = registro.idScheda;
    map["durataFinale"] = registro.durataFinale;
    map["voto"] = registro.voto;
    return map;
  }

  Future create(Registro registro) async {
    Database? db = await _getDB();
    var val = await db!.rawQuery("SELECT MAX(id) + 1 AS id FROM registri");
    int id = val.first["id"] == null ? 1 : val.first["id"] as int;
    return await db.rawInsert(
        "INSERT INTO registri (id, idScheda, durataFinale, voto)"
            "VALUES (?, ?, ?, ?)",
        [id, registro.idScheda, registro.durataFinale, registro.voto]
    );
  }

  Future<Registro> get(int inID) async {
    Database? db = await _getDB();
    var rec = await db!.query("registri", where: "id = ?", whereArgs: [inID]);
    return registroFromMap(rec.first);
  }

  Future<List> getAll(int id) async {
    Database? db = await _getDB();
    var recs = await db!.query("registri", where: "idScheda = ?", whereArgs: [id]);
    var list = recs.isEmpty ? [] : recs.map((m) => registroFromMap(m)).toList();
    return list;
  }

  Future update(Registro registro) async {
    Database? db = await _getDB();
    return await db!.update("registri", registroToMap(registro), where: "id = ?", whereArgs: [registro.id]);
  }
}