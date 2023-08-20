import 'package:flutter/material.dart';
import 'package:motilabs/screens/memo_screen.dart';

class NoteItemWidget extends StatelessWidget {
  final List mainList;

  // const FolderItem({Key? key}) : super(key: key);
  const NoteItemWidget({Key? key, required this.mainList,}) : super(key: key);

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => MemoScreen(noteTitle: mainList[index],)));
            }, child: Text(mainList[index], textAlign: TextAlign.start,),)
          ),
        );
      }, 
      separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 1); },
    );
  }
}
