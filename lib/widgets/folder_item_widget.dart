import 'package:flutter/material.dart';
import 'package:motilabs/screens/note_screen.dart';

class FolderItemWiget extends StatelessWidget {
  final List mainList;
  final Function(int) onDelete;
  final bool isEditMode;

  const FolderItemWiget({Key? key, required this.mainList, required this.onDelete, required this.isEditMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemCount: mainList.length, // make sure mainList is accessible here
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {},
          trailing: isEditMode // 편집 모드일 경우에만 삭제 버튼 표시
            ? TextButton(
                onPressed: () => onDelete(index),
                child: Text('Delete', style: TextStyle(color: Colors.red),),
              )
            : null,

          leading: Icon(Icons.folder),
          title: Container(
            alignment: Alignment.centerLeft,
            height: 50,
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
