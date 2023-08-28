import 'package:flutter/material.dart';
import 'package:motilabs/screens/memo_screen.dart';

class NoteItemWidget extends StatefulWidget {
  final List mainList;
  final Function(int index) onDelete;
  final bool isEditMode;

  const NoteItemWidget({
    Key? key,
    required this.mainList,
    required this.onDelete,
    required this.isEditMode,
  }) : super(key: key);

  @override
  State<NoteItemWidget> createState() => _NoteItemWidgetState();
}

class _NoteItemWidgetState extends State<NoteItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemCount:
          widget.mainList.length, // make sure mainList is accessible here
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Container(
            alignment: Alignment.centerLeft,
            height: 50,
            child: Text(
              widget.mainList[index]['title'],
              textAlign: TextAlign.start,
            ),
          ),
          trailing: widget.isEditMode // 편집 모드일 경우에만 삭제 버튼 표시
              ? SizedBox(
                  width: 100,
                  height: 100,
                  child: TextButton(
                    onPressed: () => widget.onDelete(index),
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                )
              : null,
          onTap: () {
            final result = Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MemoScreen(
                          memo_id: widget.mainList[index]['id'],
                        )));
            if (result == 'updated') {
              setState(() {});
              // 여기에서 데이터베이스를 새로고침하거나 필요한 작업을 수행하세요.
            }
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(thickness: 1);
      },
    );
  }
}
