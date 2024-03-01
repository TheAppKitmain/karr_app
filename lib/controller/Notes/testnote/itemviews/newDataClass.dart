class NoteResponse {
  final bool status;
  final String message;
  final List<Note> notes;

  NoteResponse({
    required this.status,
    required this.message,
    required this.notes,
  });

  factory NoteResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> notesJson = json['notes'];
    List<Note> notes = notesJson.map((noteJson) => Note.fromJson(noteJson)).toList();

    return NoteResponse(
      status: json['status'],
      message: json['message'],
      notes: notes,
    );
  }
}

class Note {
   String date;
   dynamic noteId;
   String? notes;
   String name;
   String type;

  Note({
    required this.date,
    required this.noteId,
    required this.notes,
    required this.name,
    required this.type,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      date: json['date'],
      noteId: json['note_id'],
      notes: json['notes'],
      name: json['name'],
      type: json['type'],
    );
  }
}
