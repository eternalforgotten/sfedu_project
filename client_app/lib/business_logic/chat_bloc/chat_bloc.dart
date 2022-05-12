import 'package:bloc/bloc.dart';
import 'package:client_app/classes/dish.dart';
import 'package:client_app/classes/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Message> _userMessages = [];
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  ChatBloc() : super(ChatInitial()) {
    on<FetchChatEvent>(_onUserChatFetch);
    on<SendMessageEvent>(_onSendMessage);
    on<SendOrderMessageEvent>(_onSendOrderMessage);
  }
  Future<void> _onUserChatFetch(FetchChatEvent event, Emitter emit) async {
    var doc =
        await _firebaseFirestore.collection('chats').doc(event.number).get();
    if (doc.exists) {
      var rawMessages = doc.data()['messages'] as List<dynamic>;
      List<Message> messages = [];
      rawMessages.forEach((rawMessage) {
        final data = rawMessage as Map<String, Object>;
        final message = Message.fromJson(data);
        messages.add(message);
      });
      _userMessages = messages;
    } else {
      _userMessages = [];
    }
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter emit) async {
    final number = event.number;
    final sentMessage = event.message;
    var userChat =
        await _firebaseFirestore.collection('chats').doc(number).get();

    if (userChat.exists) {
      var rawMessages = userChat.data()['messages'] as List<dynamic>;
      var addedMessage = Message(
        time: sentMessage.time,
        sender: sentMessage.sender,
        content: sentMessage.content,
        needDate: _needDate(rawMessages.isEmpty),
      );
      var messages = rawMessages
          .map((e) => Message.fromJson(e as Map<String, Object>))
          .toList();
      messages.add(addedMessage);
      var newData = messages.map((e) => e.toJson()).toList();
      await _firebaseFirestore.collection('chats').doc(number).update({
        'messages': newData,
      });
      _userMessages.add(addedMessage);
    } else {
      var addedMessage = Message(
        time: sentMessage.time,
        sender: sentMessage.sender,
        content: sentMessage.content,
        needDate: _needDate(true),
      );
      List<dynamic> newData = []..add(addedMessage.toJson());
      await _firebaseFirestore.collection('chats').doc(number).set({
        'messages': newData,
      });
      _userMessages.add(addedMessage);
    }
  }

  Future<void> _onSendOrderMessage(
      SendOrderMessageEvent event, Emitter emit) async {
    final dishes = event.dishes;
    final total = event.total;
    final number = event.number;
    var userChat =
        await _firebaseFirestore.collection('chats').doc(number).get();

    if (userChat.exists) {
      var rawMessages = userChat.data()['messages'] as List<dynamic>;
      var addedMessage = Message(
        time: DateTime.now(),
        sender: 'Superuser',
        content: _orderMessage(dishes, total),
        needDate: _needDate(rawMessages.isEmpty),
      );
      var messages = rawMessages
          .map((e) => Message.fromJson(e as Map<String, Object>))
          .toList();
      messages.add(addedMessage);
      var newData = messages.map((e) => e.toJson()).toList();
      await _firebaseFirestore.collection('chats').doc(number).update({
        'messages': newData,
      });
      _userMessages.add(addedMessage);
    } else {
      var addedMessage = Message(
        time: DateTime.now(),
        sender: 'Superuser',
        content: _orderMessage(dishes, total),
        needDate: _needDate(true),
      );
      List<dynamic> newData = []..add(addedMessage.toJson());
      await _firebaseFirestore.collection('chats').doc(number).set({
        'messages': newData,
      });
      _userMessages.add(addedMessage);
    }

    final action = event.action;
    if (action != null) {
      action();
    }
  }

  bool _needDate(bool isEmpty) {
    bool isFirstMsg = isEmpty;
    bool areDaysDiffer = _userMessages.isNotEmpty;
    return isFirstMsg || areDaysDiffer;
  }

  String _orderMessage(List<Dish> dishes, int total) {
    var content = '';
    content += 'Ваш заказ:\n';
    dishes.forEach((dish) {
      content +=
          '${dish.name} по цене ${dish.price}, ${dish.quantity} ${_adjustedQuantity(dish.quantity)}.\n';
    });
    content += 'Итого: $total.\n';
    content += 'Заказ будет ждать вас по адресу:';
    return content;
  }

  String _adjustedQuantity(int quantity) {
    int last = quantity % 10;
    if (last == 1 && !(quantity % 100 >= 11 && quantity % 100 <= 19)) {
      return 'штука';
    }
    if (last >= 2 &&
        last <= 4 &&
        !(quantity % 100 >= 11 && quantity % 100 <= 19)) {
      return 'штуки';
    } else {
      return 'штук';
    }
  }
}
