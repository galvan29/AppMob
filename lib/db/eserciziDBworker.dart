import 'dart:io';
import 'package:mytraining/models/eserciziModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class EserciziDBworker {

  EserciziDBworker._();
  static final EserciziDBworker eserciziDBworker = EserciziDBworker._();

  Database? _db;

  Future<Database?> getDB() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    if(_db==null){
      print("Sto creando il database esercizi");
      String path = join(docsDir.path, "esercizi.db");
      _db = await openDatabase(path, version: 1,
          onCreate: (Database inDB, int inVersion) async {
            await inDB.execute("CREATE TABLE IF NOT EXISTS esercizi ("
                "id INTEGER PRIMARY KEY,"
                "idScheda TEXT,"
                "nomeEsercizio TEXT,"
                "ripEsercizio TEXT,"
                "serieEsercizio TEXT,"
                "pesoEsercizio TEXT,"
                "noteEsercizio TEXT)");
          });
    }
    return _db;
  }

  Esercizio esercizioFromMap(Map inMap){
    Esercizio esercizio = Esercizio();
    esercizio.id = inMap["id"];
    esercizio.nomeEsercizio = inMap["nomeEsercizio"];
    esercizio.idScheda = inMap["idScheda"];
    esercizio.ripEsercizio = inMap["ripEsercizio"];
    esercizio.serieEsercizio = inMap["serieEsercizio"];
    esercizio.pesoEsercizio = inMap["pesoEsercizio"];
    esercizio.noteEsercizio = inMap["noteEsercizio"];
    return esercizio;
  }

  Map<String, dynamic> esercizioToMap(Esercizio esercizio) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = esercizio.id;
    map["idScheda"] = esercizio.idScheda;
    map["nomeEsercizio"] = esercizio.nomeEsercizio;
    map["ripEsercizio"] = esercizio.ripEsercizio;
    map["serieEsercizio"] = esercizio.serieEsercizio;
    map["pesoEsercizio"] = esercizio.pesoEsercizio;
    map["noteEsercizio"] = esercizio.noteEsercizio;
    return map;
  }

  Future create(Esercizio esercizio) async {
    Database? db = await getDB();
    var val = await db!.rawQuery("SELECT MAX(id) + 1 AS id FROM esercizi");
    int id = val.first["id"] == null ? 1 : val.first["id"] as int;
    return await db.rawInsert(
        "INSERT INTO esercizi (id, idScheda, nomeEsercizio, ripEsercizio, serieEsercizio, pesoEsercizio, noteEsercizio) "
            "VALUES (?, ?, ?, ?, ?, ?, ?)",
        [id, esercizio.idScheda, esercizio.nomeEsercizio, esercizio.ripEsercizio, esercizio.serieEsercizio, esercizio.pesoEsercizio, esercizio.noteEsercizio]
    );
  }

  Future<Esercizio> get(int inID) async {
    Database? db = await getDB();
    var rec = await db!.query("esercizi", where: "id = ?", whereArgs: [inID]);
    return esercizioFromMap(rec.first);
  }

  Future<List> getAll(int id) async {
    Database? db = await getDB();
    var recs = await db!.query("esercizi", where: "idScheda = ?", whereArgs: [id]);
    var list = recs.isEmpty ? [] : recs.map((m) => esercizioFromMap(m)).toList();
    return list;
  }

  Future update(Esercizio esercizio) async {
    Database? db = await getDB();
    return await db!.update("esercizi", esercizioToMap(esercizio), where: "id = ?", whereArgs: [esercizio.id]);
  }

  Future delete(int inID) async {
    Database? db = await getDB();
    return await db!.delete("esercizi", where: "id = ?", whereArgs: [inID]);
  }

}