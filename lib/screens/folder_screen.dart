import 'package:flutter/material.dart';
import 'package:motilabs/db.dart';
import 'package:motilabs/widgets/folder_item_widget.dart';
import 'package:sqflite/sqflite.dart';
import 'package:motilabs/repositories/dbhelper.dart';

class FolderScreen extends StatefulWidget {
  @override
  _FolderScreenState createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  Database? db;
  bool isEditMode = false; // 편집 모드인지 나타내는 상태 변수

  Future<List<dynamic>> get folders async {
    final db = await DBHelper().database;
    final List<Map<dynamic, dynamic>> folderList = await db.query('folders');

    return List.generate(folderList.length, (i) {
      return folderList[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Container(
          color: Colors.white,
          child: Text(
            '폴더',
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
                  style: TextStyle(color: Colors.black, fontSize: 15)
                ),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: folders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // 로딩 중 표시
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // 에러 처리
          }
          

          print("여기여기");
          print(snapshot.data!);

          return FolderItemWiget(
            mainList: snapshot.data!,
            onDelete: (index) {
              setState(() {
                deleteFolder(snapshot.data![index]['id']);
              });
              // deleteFolder(index);
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
                  final newFolderName = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return _NewFolderDialog();
                    },
                  );

                  if (newFolderName != null && newFolderName.isNotEmpty) {
                    setState(() {
                      insertFolder(newFolderName);
                    });
                  }
                },
                icon: Icon(Icons.create_new_folder)),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    ));
  }
}

class _NewFolderDialog extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('새 폴더 이름'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(hintText: "폴더 이름을 입력하세요"),
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
