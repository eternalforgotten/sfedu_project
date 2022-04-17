import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  User currentUser;
  AuthBloc() : super(AuthInitial()) {
    on<FetchUserEvent>(_onFetchUser);
  }

  Future<void> _onFetchUser(FetchUserEvent event, Emitter emit) async {
    var auth = FirebaseAuth.instance;
    currentUser = auth.currentUser;
  }
}
