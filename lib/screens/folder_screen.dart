import 'package:flutter/material.dart';
import 'package:motilabs/models/memo_data.dart';
import 'package:motilabs/widgets/folder_item_widget.dart';

class FolderScreen extends StatelessWidget {
  const FolderScreen({Key? key}) : super(key: key);

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
        body: FolderItemWiget(mainList: FolderList,),

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
