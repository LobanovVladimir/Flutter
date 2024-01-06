 // файл для работы с SQL

import "package:path/path.dart"; // кроссплатформенная работа с путями в файловой системе
import "package:sqflite/sqflite.dart";
import "../utils.dart" as utils;
import "NotesModel.dart";

class NotesDBWorker {  // 177
	 NotesDBWorker._();
	 static final NotesDBWorker db = NotesDBWorker._();
  
  Database? _db;

  Future get database async {
	 if (_db == null) {
	 	 _db = await init();
    }
  return _db;
  }

  Future<Database> init() async {
    String path = join(utils.docsDir.path, "notes.db");
    Database db = await openDatabase(
      path, version : 1, onOpen : (db) { },
      onCreate : (Database inDB, int inVersion) async {
        await inDB.execute(
          "CREATE TABLE IF NOT EXISTS notes ("
            "id INTEGER PRIMARY KEY,"
            "title TEXT,"
            "content TEXT,"
            "color TEXT"
          ")"
        );
  }
    );
  return db;
  }

  Note noteFromMap(Map inMap) 
  {
    Note note = Note();
    note.id = inMap["id"];
    note.title = inMap["title"];
    note.content = inMap["content"];
    note.color = inMap["color"];
  return note;
  }
  Map<String, dynamic> noteToMap(Note inNote) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = inNote.id;
    map["title"] = inNote.title;
    map ["content"] = inNote.content;
    map["content"] = inNote.content;
  return map;
  }

  Future create(Note inNote) async {   // CRUD Create Read Update Delete
	 Database db = await database;
	 var val = await db.rawQuery(  // запрашиваем существующие заметки
	 	 "SELECT MAX(id) + 1 AS id FROM notes"
	 );
	 int id = val.first["id"] as int; // .toString()  int.parse
	 if (id == null) { id = 1; }  //Если заметок нет то ставим 1 в ИД  
    return await db.rawInsert(
	 	 "INSERT INTO notes (id, title, content, color) "
	 	 "VALUES (?, ?, ?, ?)",
	 	 [ id, inNote.title, inNote.content, inNote.color ]
	 );
  }

  Future<Note> get(int inID) async {
	 Database db = await database;
	 var rec = await db.query(
	 	 "notes", where : "id = ?", whereArgs : [ inID ]
	 );
	 return noteFromMap(rec.first);
  }

  Future<List> getAll() async {
    Database db = await database;
    var recs = await db.query("notes"); //получаем весь список записей
    var list = recs.isNotEmpty ?  // Это лист объектов Note а база данных передает лист мап от 2 переменных что бред
    recs.map((m) => noteFromMap(m)).toList() : [ ]; // map - берет каждый элемент из списка БД и превращает каждый в запись а после делает из них список
    return list;  //180 
  }

  Future update(Note inNote) async {
	 Database db = await database;
	 return await db.update("notes", noteToMap(inNote),
	 	 where : "id = ?", whereArgs : [ inNote.id ]
	 );
  }

  Future delete(int inID) async {
	 Database db = await database;
    return await db.delete(
	 	 "notes", where : "id = ?", whereArgs : [ inID ]
	 );
  }
}