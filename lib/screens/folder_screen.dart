import 'package:flutter/material.dart';
import 'package:motilabs/models/memo_data.dart';
import 'package:motilabs/widgets/folder_item_widget.dart';

class FolderScreen extends StatefulWidget {
  @override
  _FolderScreenState createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  // 메모 데이터의 상태를 저장하는 리스트
  
  void _addNewFolder(String folderName) {
    setState(() {
      memoData.add(MemoData(folder: folderName, note: []));
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
            child: Text('폴더', style: TextStyle(color: Colors.black, fontSize: 15),),
          ),
          actions: [
            Row(
              children: [
                TextButton(onPressed: (){}, child: Text("편집", style: TextStyle(color: Colors.black, fontSize: 15),)),
              ],
            ),
          ],
        ),
        body: FolderItemWiget(mainList: memoData.map((data) => data.folder).toList(),),
        bottomNavigationBar: Container(
          height: 70,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                // IconButton(
                //   onPressed: () {
                //     // 새 폴더를 추가하는 로직
                //     setState(() {
                //       memoData.add(MemoData(folder: "NewFolder", note: []));
                //     });
                //   },
                //   icon: Icon(Icons.create_new_folder)
                // ),
                IconButton(
                  onPressed: () async {
                    final newFolderName = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return _NewFolderDialog();
                      },
                    );

                    if (newFolderName != null && newFolderName.isNotEmpty) {
                      _addNewFolder(newFolderName);
                    }
                  },
                  icon: Icon(Icons.create_new_folder)
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.black,))
            ],
          ),
        ),
      )
    );
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
