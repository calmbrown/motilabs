import 'package:flutter/material.dart';

class MemoScreen extends StatefulWidget {
  final String noteTitle;

  MemoScreen({Key? key, required this.noteTitle});

  @override
  _MemoScreenState createState() => _MemoScreenState(noteTitle: noteTitle);
}

class _MemoScreenState extends State<MemoScreen> {
  final String noteTitle;

  _MemoScreenState({Key? key, required this.noteTitle});

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
