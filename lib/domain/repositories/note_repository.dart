import '../entities/note.dart';

abstract class NoteRepository {
  Future<void> addNote(Note note);
  Future<void> editNote(Note note);
  Future<void> deleteNote(String id);
  Future<List<Note>> getNotes();
}
