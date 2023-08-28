  import 'dart:async';

  import 'package:flutter/material.dart';
  import 'package:motilabs/repositories/dbhelper.dart'; 
  import 'package:sqflite/sqflite.dart';
  import 'package:motilabs/db.dart';
  import 'package:motilabs/models/memo_data.dart';

  class MemoScreen extends StatefulWidget {
    final dynamic mainList;
    MemoScreen({Key? key, required this.mainList}) : super(key: key);

    @override
    _MemoScreenState createState() => _MemoScreenState();
  }

  class _MemoScreenState extends State<MemoScreen> {
    Database? db;
    String? test;
    Future<Note> get memo async {
      final db = await DBHelper().database;
      // final <List<Map<dynamic, dynamic>>> memoList = await db.query('notes', where: 'id = ?', whereArgs: [widget.mainList['id']]);
      final List<Map<String, dynamic>> memoList = await db.query('notes', where: 'id = ?', whereArgs: [widget.mainList]);

      return Note(
        id: memoList[0]['id'],
        title: memoList[0]['title'],
        content: memoList[0]['content'],
      );
      // return List.generate(memoList.length, (i) {
      //   return memoList[i];
      // });
    }

    TextEditingController _controller = TextEditingController();
    String _note = '';

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          centerTitle: true,
          // backgroundColor: Colors.white,
          title: FutureBuilder<Note>(
            future: memo, // your Future function here
            builder: (BuildContext context, AsyncSnapshot<Note> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No Data');
              } else {
                return Text(snapshot.data!.title); // Ensure data exists before access
              }
            },
          ),
        ),
        body: FutureBuilder<Note>(builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data!.content != null) {
              _controller.text = snapshot.data!.content!;  // controller에 텍스트를 설정
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: snapshot.data!.content == null ? '메모를 입력하세요' : null,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _note = _controller.text;
                        updateMemo(widget.mainList, _note);
                        Navigator.pop(context, 'updated');
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
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }, future: memo)
        
      );
    }

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }
  }
