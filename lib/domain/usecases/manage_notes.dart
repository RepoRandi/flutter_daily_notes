import '../entities/note.dart';
import '../repositories/note_repository.dart';

class ManageNotes {
  final NoteRepository repository;

  ManageNotes(this.repository);

  Future<void> addNote(Note note) => repository.addNote(note);
  Future<void> editNote(Note note) => repository.editNote(note);
  Future<void> deleteNote(String id) => repository.deleteNote(id);
  Future<List<Note>> getNotes() => repository.getNotes();
}
