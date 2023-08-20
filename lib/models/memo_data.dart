class MemoData {
  List note;
  String folder;
  // String note;
  // String date;
  // String time;
  // String alarm;
  // String color;
  // String image;

  MemoData({
    required this.note,
    required this.folder,
    // this.note,
    // this.date,
    // this.time,
    // this.alarm,
    // this.color,
    // this.image,
  });
}

List<MemoData> memoData = [
  MemoData(
    folder: "Cold", 
    note: ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry']
  ),
  MemoData(
    folder: "Poll", 
    note: ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry']
  ),
  MemoData(
    folder: "Beam", 
    note: ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry']
  ),
  MemoData(
    folder: "Greek", 
    note: ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry']
  ),
  MemoData(
    folder: "Song", 
    note: ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry']
  ),
  MemoData(
    folder: "Tight", 
    note: ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry']
  ),
  MemoData(
    folder: "Run", 
    note: ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry']
  ),
  MemoData(
    folder: "Count", 
    note: ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry']
  ),
];

// List<String> folderList = ['Cold', 'Poll', 'Beam', 'Greek', 'Song', 'Tight', 'Run', 'Count'];
// List<String> noteList = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
