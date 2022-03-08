import 'dart:io';
import 'package:mytraining/models/utentiModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class UtentiDBworker {

  UtentiDBworker._();
  static final UtentiDBworker utentiDBworker = UtentiDBworker._();

  Database? _db;

  Future<Database?> _getDB() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    if(_db==null){
      print("creo database utenti");
      String path = join(docsDir.path, "utenti.db");
      _db = await openDatabase(path, version: 1,
          onCreate: (Database inDB, int inVersion) async {
            await inDB.execute("CREATE TABLE IF NOT EXISTS utenti ("
                "id INTEGER PRIMARY KEY,"
                "nomeUtente TEXT,"
                "password TEXT,"
                "nome TEXT,"
                "cognome TEXT,"
                "eta TEXT)");
          });
    }
    return _db;
  }

  Utente utenteFromMap(Map inMap){
    Utente utente = Utente();
    utente.id = inMap["id"];
    utente.nomeUtente = inMap["nomeUtente"];
    utente.password = inMap["password"];
    utente.nome = inMap["nome"];
    utente.cognome = inMap["cognome"];
    utente.eta = inMap["eta"];
    return utente;
  }

  Map<String, dynamic> utenteToMap(Utente utente) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = utente.id;
    map["nomeUtente"] = utente.nomeUtente;
    map["password"] = utente.password;
    map["nome"] = utente.nome;
    map["cognome"] = utente.cognome;
    map["eta"] = utente.eta;
    return map;
  }

  Future create(Utente utenti) async {
    Database? db = await _getDB();
    var val = await db!.rawQuery("SELECT MAX(id) + 1 AS id FROM utenti");
    int id = val.first["id"] == null ? 1 : val.first["id"] as int;
    return await db.rawInsert(
        "INSERT INTO utenti (id, nomeUtente, password, nome, cognome, eta) "
            "VALUES (?, ?, ?, ?, ?, ?)",
        [id, utenti.nomeUtente, utenti.password, utenti.nome, utenti.cognome, utenti.eta]
    );
  }

  Future<Utente> get(int inID) async {
    Database? db = await _getDB();
    var rec = await db!.query("utenti", where: "id = ?", whereArgs: [inID]);
    return utenteFromMap(rec.first);
  }

  Future<Utente> getPassword(String nomeUtente) async {
    Database? db = await _getDB();
    var rec = await db!.query("utenti", where: "nomeUtente = ?", whereArgs: [nomeUtente]);
    return utenteFromMap(rec.first);
  }

  Future<Utente> getId(String nomeUtente) async {
    Database? db = await _getDB();
    var rec = await db!.query("utenti", where: "nomeUtente = ?", whereArgs: [nomeUtente]);
    return utenteFromMap(rec.first);
  }

  Future<List> getAll() async {
    Database? db = await _getDB();
    var recs = await db!.query("utenti");
    var list = recs.isEmpty ? [] : recs.map((m) => utenteFromMap(m)).toList();
    return list;
  }

  Future update(Utente utente) async {
    Database? db = await _getDB();
    return await db!.update("utenti", utenteToMap(utente), where: "id = ?", whereArgs: [utente.id]);
  }

  Future delete(int inID) async {
    Database? db = await _getDB();
    return await db!.delete("utenti", where: "id = ?", whereArgs: [inID]);
  }

}