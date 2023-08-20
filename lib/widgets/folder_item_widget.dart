import 'package:flutter/material.dart';
import 'package:motilabs/screens/note_screen.dart';

class FolderItemWiget extends StatelessWidget {
  final List mainList;

  // const FolderItemWiget({Key? key}) : super(key: key);
  const FolderItemWiget({Key? key, required this.mainList}) : super(key: key);

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen(folderTitle: mainList[index],)));
            }, child: Text(mainList[index], textAlign: TextAlign.start,),)
          ),
        );
      }, 
      separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 1); },
    );
  }
}
