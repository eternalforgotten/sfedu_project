part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class FetchUserEvent extends AuthEvent {}

class SendCodeEvent extends AuthEvent {
  final String code;
  final String verificationId;

  SendCodeEvent(this.code, this.verificationId);
}

class SendNumberEvent extends AuthEvent {
  final String phone;

  SendNumberEvent(this.phone);
}

class SignOutEvent extends AuthEvent {}
