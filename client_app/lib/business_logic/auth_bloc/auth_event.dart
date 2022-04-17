part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class FetchUserEvent extends AuthEvent {}
