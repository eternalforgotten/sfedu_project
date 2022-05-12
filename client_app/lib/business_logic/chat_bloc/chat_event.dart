part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class FetchChatEvent extends ChatEvent {
  final String number;

  FetchChatEvent({this.number});
}

class SendMessageEvent extends ChatEvent {
  final String number;
  final Message message;

  SendMessageEvent(this.message, this.number);
}

class SendOrderMessageEvent extends ChatEvent {
  final String number;
  final List<Dish> dishes;
  final int total;
  final VoidCallback action;

  SendOrderMessageEvent({
    this.action,
    @required this.dishes,
    @required this.number,
    @required this.total,
  });
}
