import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User currentUser;
  String verificationId;
  AuthBloc() : super(AuthInitial()) {
    on<FetchUserEvent>(_onFetchUser);
    on<SendNumberEvent>(_sendNumberEvent);
    on<SendCodeEvent>(_sendCodeEvent);
    on<SignOutEvent>(_signOutEvent);
  }

  Future<void> _onFetchUser(FetchUserEvent event, Emitter emit) async {
    if (currentUser == null) {
      emit(UserNonAuthenticatedState());
    } else {
      emit(UserAuthenticatedState(currentUser.phoneNumber));
    }
  }

  Future<void> _sendNumberEvent(SendNumberEvent event, Emitter emit) async {
    final string = event.phone;
    if (!_validateNumber(string)) {
      emit(AuthErrorState('Введите верный номер телефона!'));
      return;
    }
    String number = '';
    number += string.substring(0, 2);
    number += string.substring(3, 6);
    number += string.substring(7, 10);
    number += string.substring(11, 13);
    number += string.substring(14, 16);
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (credential) {},
        verificationFailed: (e) {},
        codeSent: (verificationId, token) {
          print('the id is ' + verificationId);
          this.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (_) {},
      );
      emit(NumberSentState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _sendCodeEvent(SendCodeEvent event, Emitter emit) async {
    final code = event.code;
    final verificationId = event.verificationId;
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: code,
    );
    try {
      var userCredential = await _auth.signInWithCredential(credential);
      currentUser = userCredential.user;
      emit(UserAuthenticatedState(
        currentUser.phoneNumber,
      ));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _signOutEvent(SignOutEvent event, Emitter emit) async {
    final auth = FirebaseAuth.instance;
    await auth.signOut();
    currentUser = null;
    emit(UserNonAuthenticatedState());
  }

  bool _validateNumber(String number) {
    final isNotEmpty = number.isNotEmpty;
    final hasCorrectLength = number.length == 16;
    return isNotEmpty && hasCorrectLength;
  }
}
