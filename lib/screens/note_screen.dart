import 'package:flutter/material.dart';
import 'package:motilabs/repositories/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:motilabs/db.dart';
import 'package:motilabs/widgets/note_item_widget.dart';
// import 'package:motilabs/repositories/dbhelper.dart';

class NoteScreen extends StatefulWidget {
  final String folderTitle;
  final int folderId;

  const NoteScreen({Key? key, required this.folderTitle, required this.folderId}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  Database? db;
  bool isEditMode = false; // 편집 모드인지 나타내는 상태 변수

  Future<List<dynamic>> get notes async {
    final db = await DBHelper().database;
    print("testtsafsfasdfasdfasd");
    print(widget.folderId);
    print("testtsafsfasdfasdfasd");
    final List<Map<dynamic, dynamic>> noteList = await db.query('notes', where: 'folder_id = ?', whereArgs: [widget.folderId]);
    // final List<Map<dynamic, dynamic>> noteList = await db.query('notes');

    return List.generate(noteList.length, (i) {
      if (noteList[i]['title'] == null) {
        updateNote(
          noteList[i]['id'], "제목 없음"
        );
      }
      return noteList[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Container(
          color: Colors.white,
          child: Text(
            widget.folderTitle,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
        actions: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      isEditMode = !isEditMode; // 편집 모드를 토글
                    });
                  },
                  child: Text(
                    "편집",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  )
                  ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: notes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // 로딩 중 표시
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // 에러 처리
          }

          return NoteItemWidget(
            mainList: snapshot.data!,
            onDelete: (index) {
              deleteFolder(snapshot.data![index]['id']);
            },
            isEditMode: isEditMode,
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () async {
                  final newNoteName = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return _NewNoteDialog();
                    },
                  );

                  if (newNoteName != null && newNoteName.isNotEmpty) {
                    setState(() {
                      insertNote(widget.folderId,newNoteName);
                    });
                  }
                },
                icon: Icon(
                  Icons.note_add,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }
}

class _NewNoteDialog extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('새 노트 이름'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(hintText: "노트 이름을 입력하세요"),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('취소'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('추가'),
          onPressed: () {
            Navigator.of(context).pop(_controller.text);
          },
        ),
      ],
    );
  }
}
