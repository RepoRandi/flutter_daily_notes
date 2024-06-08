part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class LoadNotes extends NotesEvent {}

class AddNote extends NotesEvent {
  final Note note;

  const AddNote(this.note);

  @override
  List<Object> get props => [note];
}

class EditNote extends NotesEvent {
  final Note note;

  const EditNote(this.note);

  @override
  List<Object> get props => [note];
}

class DeleteNote extends NotesEvent {
  final String id;

  const DeleteNote(this.id);

  @override
  List<Object> get props => [id];
}
