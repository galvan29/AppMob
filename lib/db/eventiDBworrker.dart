import 'dart:io';
import 'package:mytraining/models/eventiModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class EventiDBworker {

  EventiDBworker._();
  static final EventiDBworker eventiDBworker = EventiDBworker._();

  Database? _db;

  Future<Database?> _getDB() async {
    print("cerco di watch");
    Directory docsDir = await getApplicationDocumentsDirectory();
    if(_db==null){
      print("Sto creando il database eventi");
      String path = join(docsDir.path, "eventi.db");
      _db = await openDatabase(path, version: 1,
          onCreate: (Database inDB, int inVersion) async {
            await inDB.execute("CREATE TABLE IF NOT EXISTS eventi ("
                "id INTEGER PRIMARY KEY,"
                "idUtente TEXT,"
                "nomeScheda TEXT,"
                "inizio DATETIME,"
                "fine DATETIME)");
          });
    }
    return _db;
  }

  Evento eventoFromMap(Map inMap){
    Evento evento = Evento();
    evento.id = inMap["id"];
    evento.idUtente = inMap["idUtente"];
    evento.nomeScheda = inMap["nomeScheda"];
    evento.inizio = DateTime.parse(inMap["inizio"]);
    evento.fine = DateTime.parse(inMap["fine"]);
    return evento;
  }

  Map<String, dynamic> eventoToMap(Evento evento) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = evento.id;
    map["idUtente"] = evento.idUtente;
    map["nomeScheda"] = evento.nomeScheda;
    map["inizio"] = evento.inizio;
    map["fine"] = evento.fine;
    return map;
  }

  Future create(Evento evento) async {
    Database? db = await _getDB();
    print("dentro create eventi");
    var val = await db!.rawQuery("SELECT MAX(id) + 1 AS id FROM eventi");
    int id = val.first["id"] == null ? 1 : val.first["id"] as int;
    return await db.rawInsert(
        "INSERT INTO eventi (id, idUtente, nomeScheda, inizio, fine) "
            "VALUES (?, ?, ?, ?, ?)",
        [id, evento.idUtente, evento.nomeScheda, evento.inizio.toString(), evento.fine.toString()]
    );
  }

  Future<Evento> get(int inID) async {
    Database? db = await _getDB();
    var rec = await db!.query("eventi", where: "id = ?", whereArgs: [inID]);
    return eventoFromMap(rec.first);
  }

  Future<List> getAll(int id) async {
    Database? db = await _getDB();
    var recs = await db!.query("eventi", where: "idUtente = ?", whereArgs: [id]);
    var list = recs.isEmpty ? [] : recs.map((m) => eventoFromMap(m)).toList();
    return list;
  }

  Future update(Evento evento) async {
    Database? db = await _getDB();
    return await db!.update("eventi", eventoToMap(evento), where: "id = ?", whereArgs: [evento.id]);
  }

  Future delete(int inID) async {
    Database? db = await _getDB();
    return await db!.delete("eventi", where: "id = ?", whereArgs: [inID]);
  }

}