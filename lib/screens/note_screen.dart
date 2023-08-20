import 'package:flutter/material.dart'; 
import 'package:motilabs/models/memo_data.dart';
import 'package:motilabs/widgets/note_item_widget.dart'; 

class NoteScreen extends StatelessWidget {
  final String folderTitle;

  const NoteScreen({Key? key, required this.folderTitle}) : super(key: key);

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
        child: NoteItemWidget(mainList: memoData.firstWhere((data) => data.folder == folderTitle).note,),

      ),
    );
  }
}
