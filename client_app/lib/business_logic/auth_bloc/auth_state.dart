part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class FetchedUser extends AuthState {
  final User user;

  FetchedUser(this.user);
}
