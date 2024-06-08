import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/notes/notes_bloc.dart';
import '../../domain/entities/note.dart';

class AddNotePage extends StatefulWidget {
  final Note? note;

  const AddNotePage({super.key, this.note});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  DateTime? _reminderTime;

  @override
  void initState() {
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _reminderTime = widget.note!.reminderTime;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(_reminderTime == null
                  ? 'Set Reminder'
                  : 'Reminder: ${DateFormat.yMd().add_jm().format(_reminderTime!)}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _reminderTime ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (picked != null) {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      _reminderTime = DateTime(
                        picked.year,
                        picked.month,
                        picked.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  }
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final content = _contentController.text;
                if (widget.note == null) {
                  final note = Note(
                    id: DateTime.now().toString(),
                    title: title,
                    content: content,
                    reminderTime: _reminderTime!,
                  );
                  context.read<NotesBloc>().add(AddNote(note));
                } else {
                  final note = Note(
                    id: widget.note!.id,
                    title: title,
                    content: content,
                    reminderTime: _reminderTime!,
                  );
                  context.read<NotesBloc>().add(EditNote(note));
                }
                Navigator.of(context).pop();
              },
              child: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
            ),
          ],
        ),
      ),
    );
  }
}
