import 'package:motilabs/repositories/dbhelper.dart';
import 'package:motilabs/models/memo_data.dart';

Future<void> createFolder(String name) async {
  final db = await DBHelper().database;

  await db.insert('folders', {'name': name});
}

Future<List<dynamic>> readFolders() async {
  final db = await DBHelper().database;
  final List<Map<dynamic, dynamic>> folderList = await db.query('folders');

  return List.generate(folderList.length, (i) {
    return folderList[i];
  });
}

Future<void> updateFolder(String name) async {
  final db = await DBHelper().database;

  await db.update('folders', {'name': name},
      where: 'id = ?', whereArgs: [name]);
}

Future<void> deleteFolder(int id) async {
  final db = await DBHelper().database;

  await db.delete('folders', where: 'id = ?', whereArgs: [id]);
  await db.delete('notes', where: 'folder_id = ?', whereArgs: [id]);
}

Future<void> createNote(int id, String title) async {
  final db = await DBHelper().database;

  await db.insert('notes', {'title': title, 'folder_id': id});
}

Future<List<dynamic>> readNote(int id) async {
  final db = await DBHelper().database;
  final List<Map<dynamic, dynamic>> noteList =
      await db.query('notes', where: 'folder_id = ?', whereArgs: [id]);

  return List.generate(noteList.length, (i) {
    if (noteList[i]['title'] == null) {
      updateNote(noteList[i]['id'], "제목 없음");
    }
    return noteList[i];
  });
}

Future<void> updateNote(int id, String title) async {
  final db = await DBHelper().database;

  await db.update('notes', {'title': title}, where: 'id = ?', whereArgs: [id]);
}

Future<void> createMemo(int id, String title) async {
  final db = await DBHelper().database;

  await db.insert('notes', {'title': title, 'folder_id': id});
}

Future<Note> readMemo(int id) async {
  final db = await DBHelper().database;
  final List<Map<dynamic, dynamic>> memoList =
      await db.query('notes', where: 'id = ?', whereArgs: [id]);

  return Note(
    id: memoList[0]['id'],
    title: memoList[0]['title'],
    content: memoList[0]['content'],
  );
}

Future<void> updateMemo(int id, String content) async {
  final db = await DBHelper().database;

  // await db.insert('notes', {'content':  content});
  await db.update('notes', {'content': content},
      where: 'id = ?', whereArgs: [id]);
}

Future<void> deleteNote(int id) async {
  final db = await DBHelper().database;

  await db.delete('notes', where: 'id = ?', whereArgs: [id]);
}
