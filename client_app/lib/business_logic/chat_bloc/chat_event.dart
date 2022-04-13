part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class FetchChatEvent extends ChatEvent {
  final String number;

  FetchChatEvent(this.number);
}

class SendMessageEvent extends ChatEvent {
  final String number;
  final Message message;

  SendMessageEvent(this.message, this.number);
}
