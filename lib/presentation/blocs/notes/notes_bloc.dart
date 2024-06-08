import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/note.dart';
import '../../../domain/usecases/manage_notes.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final ManageNotes manageNotes;

  NotesBloc(this.manageNotes) : super(NotesInitial()) {
    on<LoadNotes>((event, emit) async {
      emit(NotesLoading());
      try {
        final notes = await manageNotes.getNotes();
        emit(NotesLoaded(notes));
      } catch (_) {
        emit(const NotesError("Couldn't fetch notes. Is the device online?"));
      }
    });

    on<AddNote>((event, emit) async {
      await manageNotes.addNote(event.note);
      add(LoadNotes());
    });

    on<EditNote>((event, emit) async {
      await manageNotes.editNote(event.note);
      add(LoadNotes());
    });

    on<DeleteNote>((event, emit) async {
      await manageNotes.deleteNote(event.id);
      add(LoadNotes());
    });
  }
}
