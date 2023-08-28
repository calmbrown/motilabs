
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() { return _instance; }

  DBHelper._internal();
  
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    
    final database = openDatabase(
        join(await getDatabasesPath(), 'memos.db'),
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE folders (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT
        );
      ''');
      await db.execute('''
        DROP TABLE IF EXISTS notes;
      ''');
      await db.execute('''
        CREATE TABLE notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          folder_id INTEGER,
          title TEXT default '제목 없음',
          content TEXT,
          FOREIGN KEY(folder_id) REFERENCES folders(id)
        );
      ''');
      await db.execute('''
        INSERT INTO folders (name) VALUES ('Default');
      ''');
    }, version: 1);
    return database;
  }

}

