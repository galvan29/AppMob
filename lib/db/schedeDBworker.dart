import 'dart:io';

import 'package:mytraining/models/schedeModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mytraining/common/utils.dart' as utils;

class SchedeDBworker {

  SchedeDBworker._();
  static final SchedeDBworker schedeDBworker = SchedeDBworker._();

  Database? _db;

  Future<Database?> _getDB() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    if(_db==null){
      print("Sto creando il database schede");
      String path = join(docsDir.path, "schede.db");
      _db = await openDatabase(path, version: 1,
          onCreate: (Database inDB, int inVersion) async {
            await inDB.execute("CREATE TABLE IF NOT EXISTS schede ("
                "id INTEGER PRIMARY KEY,"
                "nomeScheda TEXT,"
                "durataScheda TEXT)");
          });
    }
    return _db;
  }

  Scheda schedaFromMap(Map inMap){
    Scheda scheda = Scheda();
    scheda.id = inMap["id"];
    scheda.nomeScheda = inMap["nomeScheda"];
    scheda.durataScheda = inMap["durataScheda"];
    return scheda;
  }

  Map<String, dynamic> schedaToMap(Scheda scheda) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = scheda.id;
    map["nomeScheda"] = scheda.nomeScheda;
    map["durataScheda"] = scheda.durataScheda;
    return map;
  }

  Future create(Scheda scheda) async {
    Database? db = await _getDB();
    var val = await db!.rawQuery("SELECT MAX(id) + 1 AS id FROM schede");
    int id = val.first["id"] == null ? 1 : val.first["id"] as int;
    return await db.rawInsert(
        "INSERT INTO schede (id, nomeScheda, durataScheda) "
            "VALUES (?, ?, ?)",
        [id, scheda.nomeScheda, scheda.durataScheda]
    );
  }

  Future<Scheda> get(int inID) async {
    Database? db = await _getDB();
    var rec = await db!.query("schede", where: "id = ?", whereArgs: [inID]);
    return schedaFromMap(rec.first);
  }

  Future<List> getAll() async {
    Database? db = await _getDB();
    var recs = await db!.query("schede");
    var list = recs.isEmpty ? [] : recs.map((m) => schedaFromMap(m)).toList();
    return list;
  }

  Future update(Scheda scheda) async {
    Database? db = await _getDB();
    return await db!.update("schede", schedaToMap(scheda), where: "id = ?", whereArgs: [scheda.id]);
  }

  Future delete(int inID) async {
    Database? db = await _getDB();
    return await db!.delete("schede", where: "id = ?", whereArgs: [inID]);
  }

}