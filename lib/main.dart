import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/notes/notes_bloc.dart';
import 'presentation/pages/login_page.dart';
import 'data/repositories/note_repository_impl.dart';
import 'domain/usecases/manage_notes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(
            create: (context) =>
                NotesBloc(ManageNotes(NoteRepositoryImpl()))..add(LoadNotes())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily Notes App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      ),
    );
  }
}
