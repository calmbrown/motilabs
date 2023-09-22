import 'package:flutter/material.dart';
import 'package:motilabs/db.dart';
import 'package:motilabs/widgets/folder_item_widget.dart';
import 'package:motilabs/screens/memo_screen.dart';

class FolderScreen extends StatefulWidget {
  @override
  _FolderScreenState createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  bool isEditMode = false; // 편집 모드인지 나타내는 상태 변수

  Future<List<dynamic>> get folders async {
    return await readFolders();
  }

  void updateFolderName(name, id) {
    setState(() {
      updateFolder(name, id);
    });
  }

  void deleteFolderName(id) {
    setState(() {
      deleteFolder(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
                    child: Text("편집",
                        style: TextStyle(color: Colors.black, fontSize: 15)),
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

              return FolderItemWiget(
                mainList: snapshot.data!,
                onDelete: (index) async {
                  // setState(() {
                  //   deleteFolder(snapshot.data![index]['id']);
                  // });
                  final newFolderName = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return _EditDialog(
                        snapshot.data![index],
                        updateFolderName,
                        deleteFolderName,
                      );
                    },
                  );

                  if (newFolderName != null && newFolderName.isNotEmpty) {
                    setState(() {
                      deleteFolder(snapshot.data![index]['id']);
                    });
                  }
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
                          createFolder(newFolderName);
                        });
                      }
                    },
                    icon: Icon(Icons.create_new_folder)),
                IconButton(
                    onPressed: () async {
                      final result = await showDialog<Map<String, dynamic>>(
                        context: context,
                        builder: (BuildContext context) {
                          return _NewNoteDialog();
                        },
                      );

                      if (result != null &&
                          result['noteName'].isNotEmpty &&
                          result['folderId'] != null) {
                        try {
                          int createdMemoId = await createMemo(
                              result['folderId'], result['noteName']);
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MemoScreen(memo_id: createdMemoId),
                              ),
                            );
                          });
                        } catch (e) {
                          // 예외 처리
                          print('Error creating memo: $e');
                        }
                      }
                    },
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

class _NewNoteDialog extends StatefulWidget {
  @override
  _NewNoteDialogState createState() => _NewNoteDialogState();
}

class _NewNoteDialogState extends State<_NewNoteDialog> {
  final TextEditingController _controller = TextEditingController();
  Map<dynamic, dynamic>? selectedFolder;

  Future<List<dynamic>> get folders async {
    return await readFolders();
  }

  @override
  void initState() {
    super.initState();
    _initializeSelectedFolder();
  }

  void _initializeSelectedFolder() async {
    List<dynamic> folderList = await folders;
    if (folderList.isNotEmpty) {
      selectedFolder = folderList.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('새 노트 이름'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "노트 이름을 입력하세요"),
          ),
          SizedBox(height: 20),
        ],
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
            Navigator.of(context).pop({
              'noteName': _controller.text,
              'folderId': selectedFolder?['id'],
            });
          },
        ),
      ],
    );
  }
}

class _EditDialog extends StatefulWidget {
  final Map<dynamic, dynamic> folder;
  final Function(String, int) updateFolderName;
  final Function(int) deleteFolderName;

  const _EditDialog(this.folder, this.updateFolderName, this.deleteFolderName);

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<_EditDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.folder['name']);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Text('편집'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: widget.folder['name']),
              ),
              ElevatedButton(
                onPressed: () {
                  // Edit action here
                  print("Edit clicked");
                  widget.updateFolderName(
                      _controller.text, widget.folder['id']);
                  Navigator.of(context).pop();
                },
                child: Text('수정'),
              ),
              SizedBox(height: 10), // Add some space between the buttons
              ElevatedButton(
                onPressed: () {
                  // Delete action here
                  print("Delete clicked");
                  widget.deleteFolderName(widget.folder['id']);
                  Navigator.of(context).pop();
                },
                child: Text('삭제'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
