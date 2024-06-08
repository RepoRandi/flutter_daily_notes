import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 2));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', event.username);
      await prefs.setString('password', event.password);
      emit(AuthRegistered());
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 2));
      final prefs = await SharedPreferences.getInstance();
      final storedUsername = prefs.getString('username');
      final storedPassword = prefs.getString('password');

      if (storedUsername == event.username &&
          storedPassword == event.password) {
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError('Invalid credentials'));
      }
    });

    on<LogoutEvent>((event, emit) {
      emit(AuthInitial());
    });
  }
}
