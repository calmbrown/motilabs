import 'package:flutter/material.dart';
import 'package:motilabs/db.dart';
import 'package:motilabs/widgets/note_item_widget.dart';
import 'package:motilabs/screens/memo_screen.dart';

class NoteScreen extends StatefulWidget {
  final Map folder;

  const NoteScreen({Key? key, required this.folder}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  bool isEditMode = false; // 편집 모드인지 나타내는 상태 변수

  Future<List<dynamic>> get notes async {
    return await readNote(widget.folder['id']);
  }

  void updateNoteName(id, title) {
    setState(() {
      updateNote(id, title);
    });
  }

  void deleteNoteName(id) {
    setState(() {
      deleteNote(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context, 'updated');
          },
        ),
        title: Container(
          child: Text(
            widget.folder['name'],
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
                  )),
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
            onDelete: (index) async {
              final newNoteName = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return _EditDialog(
                    snapshot.data![index], updateNoteName, deleteNoteName,
                  );
                },
              );
              if (newNoteName != null && newNoteName.isNotEmpty) {
                setState(() {
                  deleteNote(snapshot.data![index]['id']);
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
                  final newNoteName = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return _NewNoteDialog();
                    },
                  );

                  if (newNoteName != null && newNoteName.isNotEmpty) {
                    setState(() {
                      createNote(widget.folder['id'], newNoteName);
                    });
                  }
                },
                icon: Icon(
                  Icons.note_add,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () async {
                  final newNoteName = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return _NewNoteDialog();
                    },
                  );

                  if (newNoteName != null && newNoteName.isNotEmpty) {
                    try {
                      int createdMemoId =
                          await createMemo(widget.folder['id'], newNoteName);
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


class _EditDialog extends StatefulWidget {
  final Map<dynamic, dynamic> note;  
  final Function(int, String) updateNoteName;
  final Function(int) deleteNoteName;

  const _EditDialog(this.note, this.updateNoteName, this.deleteNoteName);

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<_EditDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.note['title']);
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
                decoration: InputDecoration(hintText: widget.note['title']),
              ),
              ElevatedButton(
                onPressed: () {
                  // Edit action here
                  print("Edit clicked");
                  widget.updateNoteName(widget.note['id'], _controller.text);  
                  Navigator.of(context).pop();
                },
                child: Text('수정'),
              ),
              SizedBox(height: 10),  // Add some space between the buttons
              ElevatedButton(
                onPressed: () {
                  // Delete action here
                  print("Delete clicked");
                  widget.deleteNoteName(widget.note['id']);  
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
