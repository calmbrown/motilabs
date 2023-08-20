import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const data = [
  "ChesPress",
  "Squat",
  "DeadLift",
  "PullUp",
  "OverHeadPress",
];


List<String> FolderList = ['Cold', 'Poll', 'Beam', 'Greek', 'Song', 'Tight', 'Run', 'Count'];
List<String> NoteList = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        body: FolderItem(mainList: FolderList,),

        bottomNavigationBar: Container(
          height: 70,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.create_new_folder)),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.black,))
            ],
          ),
        ),
      )
    );
  }
}

class HeaderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('폴더', style: TextStyle(color: Colors.black, fontSize: 15),),
    );
  }
}

class FolderItem extends StatelessWidget {
  final List mainList;

  // const FolderItem({Key? key}) : super(key: key);
  const FolderItem({Key? key, required this.mainList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemCount: mainList.length, // make sure mainList is accessible here
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {},
          leading: Icon(Icons.folder),
          title: Container(
            alignment: Alignment.centerLeft,
            height: 50,
            // child: Text(mainList[index], textAlign: TextAlign.start,),
            child: TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotePage(folderTitle: mainList[index],)));
            }, child: Text(mainList[index], textAlign: TextAlign.start,),)
          ),
        );
      }, 
      separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 1); },
    );
  }
}

class NoteItem extends StatelessWidget {
  final List mainList;

  // const FolderItem({Key? key}) : super(key: key);
  const NoteItem({Key? key, required this.mainList,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemCount: mainList.length, // make sure mainList is accessible here
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {},
          title: Container(
            alignment: Alignment.centerLeft,
            height: 50,
            // child: Text(mainList[index], textAlign: TextAlign.start,),
            child: TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen(noteTitle: NoteList[index],)));
            }, child: Text(mainList[index], textAlign: TextAlign.start,),)
          ),
        );
      }, 
      separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 1); },
    );
  }
}

class NotePage extends StatelessWidget {
  final String folderTitle;

  const NotePage({Key? key, required this.folderTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        toolbarHeight: 40,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Container(
          color: Colors.white,
          child: Text(folderTitle, style: TextStyle(color: Colors.black, fontSize: 15),),
        ),
        actions: [
          Row(
            children: [
              TextButton(onPressed: (){}, child: Text("편집", style: TextStyle(color: Colors.black, fontSize: 15),)),
            ],
          ),
        ],
      ),
      body: Container(
        child: NoteItem(mainList: NoteList,),

      ),
    );
  }
}


class NoteScreen extends StatefulWidget {
  final String noteTitle;

  NoteScreen({Key? key, required this.noteTitle});

  @override
  _NoteScreenState createState() => _NoteScreenState(noteTitle: noteTitle);
}

class _NoteScreenState extends State<NoteScreen> {
  final String noteTitle;

  _NoteScreenState({Key? key, required this.noteTitle});

  TextEditingController _controller = TextEditingController();
  String _note = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Container(
          color: Colors.white,
          child: Text(noteTitle, style: TextStyle(color: Colors.black, fontSize: 15),),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '메모를 작성하세요...',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _note = _controller.text;
                });
              },
              child: Text('저장'),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _note,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
