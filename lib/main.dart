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

List<String> mainList = ['Cold', 'Poll', 'Beam', 'Greek', 'Song', 'Tight', 'Run', 'Count'];

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
        body: FolderItem(),

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
  const FolderItem({Key? key}) : super(key: key);

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
            child: Text(mainList[index], textAlign: TextAlign.start,),
          ),
        );
      }, 
      separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 1); },
    );
  }
}
