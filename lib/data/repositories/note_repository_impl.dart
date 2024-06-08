import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../models/note_model.dart';
import 'dart:convert';

class NoteRepositoryImpl implements NoteRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> addNote(Note note) async {
    final SharedPreferences prefs = await _prefs;
    List<NoteModel> notes = await getNotes();
    notes.add(NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      reminderTime: note.reminderTime,
    ));
    prefs.setString(
        'notes', jsonEncode(notes.map((note) => note.toJson()).toList()));
  }

  @override
  Future<void> editNote(Note note) async {
    final SharedPreferences prefs = await _prefs;
    List<NoteModel> notes = await getNotes();
    int index = notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      notes[index] = NoteModel(
        id: note.id,
        title: note.title,
        content: note.content,
        reminderTime: note.reminderTime,
      );
      prefs.setString(
          'notes', jsonEncode(notes.map((note) => note.toJson()).toList()));
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    final SharedPreferences prefs = await _prefs;
    List<NoteModel> notes = await getNotes();
    notes.removeWhere((note) => note.id == id);
    prefs.setString(
        'notes', jsonEncode(notes.map((note) => note.toJson()).toList()));
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    final SharedPreferences prefs = await _prefs;
    var data = prefs.getString('notes');
    if (data != null) {
      return (jsonDecode(data) as List)
          .map((item) => NoteModel.fromJson(item))
          .toList();
    } else {
      return [];
    }
  }
}
