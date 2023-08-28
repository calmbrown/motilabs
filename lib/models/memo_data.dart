class Folder {
  final String folder_name;
  Folder({required this.folder_name});
}

class Note {
  final int id;
  final String title;
  final String? content;
  Note({required this.id, required this.title, required this.content});
}
