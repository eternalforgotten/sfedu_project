part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class FetchedUser extends AuthState {
  final User user;

  FetchedUser(this.user);
}

class NumberSentState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState(this.message);
}

class UserAuthenticatedState extends AuthState {
  final String userPhone;

  UserAuthenticatedState(this.userPhone);
}

class UserNonAuthenticatedState extends AuthState {}
