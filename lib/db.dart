import '../models/memo_data.dart';
import 'package:motilabs/repositories/dbhelper.dart';

Future<List<Folder>> getFolders() async {
  final db = await DBHelper().database;
  final List<Map<String, dynamic>> folderList = await db.query('folders');

  return List.generate(folderList.length, (i) {
    return Folder(
      folder_name: folderList[i]['name'],
    );
  });
}

Future<void> insertFolder(String name) async {
  final db = await DBHelper().database;

  await db.insert('folders', {'name': name});
}

Future<void> updateFolder(String name) async {
  final db = await DBHelper().database;

  // await db.insert('folders', where 'id = ?',{'name': name});
  await db.update('folders', {'name': name}, where: 'id = ?', whereArgs: [name]);
}

Future<void> deleteFolder(int id) async {
  final db = await DBHelper().database;

  // print('object');
  // print(db.query('notes', where: 'folder_id = ?', whereArgs: [id]).toString());
  // print('object');
  await db.delete('folders', where: 'id = ?', whereArgs: [id]);
  await db.delete('notes', where: 'folder_id = ?', whereArgs: [id]);
}

Future<List<Note>> getNotes(int id) async {
  final db = await DBHelper().database;
  final List<Map<String, dynamic>> noteList = await db.query('notes');

  return List.generate(noteList.length, (i) {
    return Note(
      id: noteList[i]['id'],
      title: noteList[i]['title'],
      content: noteList[i]['content'],
    );
  });
}

Future<void> insertNote(int id, String title) async {
  final db = await DBHelper().database;

  await db.insert('notes', {'title':  title, 'folder_id': id});
}

Future<void> updateNote(int id, String title) async {
  final db = await DBHelper().database;

  await db.update('notes', {'title': title}, where: 'id = ?', whereArgs: [id]);
}


Future<void> updateMemo(int id, String content) async {
  final db = await DBHelper().database;

  // await db.insert('notes', {'content':  content});
  await db.update('notes', {'content': content}, where: 'id = ?', whereArgs: [id]);
}

Future<void> deleteNote(int id) async {
  final db = await DBHelper().database;

  await db.delete('notes', where: 'id = ?', whereArgs: [id]);
}
