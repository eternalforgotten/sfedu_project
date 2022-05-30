import 'package:bloc/bloc.dart';
import 'package:client_app/classes/dish.dart';
import 'package:client_app/classes/message.dart';
import 'package:client_app/classes/order_data.dart';
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
      _userMessages = [...messages];
    }
    else {
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
        time: DateTime.now(),
        sender: 'User',
        content: sentMessage,
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
        sender: 'User',
        content: sentMessage,
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
    OrderData orderData = OrderData(
      dishes: dishes,
      totalPrice: total,
      userPhone: number,
    );
    await _firebaseFirestore.collection('orders').add(orderData.toJson());
    final action = event.action;
    if (action != null) {
      action();
    }
  }

  bool _needDate(bool isEmpty) {
    bool areDaysDiffer = _userMessages.isNotEmpty && _userMessages.last.time.day != DateTime.now().day;
    return isEmpty || areDaysDiffer;
  }

  String _orderMessage(List<Dish> dishes, int total) {
    var content = '';
    content += 'Ваш заказ:\n';
    dishes.forEach((dish) {
      content +=
          '${dish.name} по цене ${_adjustedPrice(dish.price)}, ${_adjustedQuantity(dish.quantity)}.\n';
    });
    content += 'Итого: $total.\n';
    content += 'Заказ будет ждать вас по адресу нашего ресторана';
    return content;
  }

  String _adjustedQuantity(int quantity) {
    assert(quantity > 0);
    int last = quantity % 10;
    if (last == 1 && !(quantity % 100 >= 11 && quantity % 100 <= 19)) {
      return '$quantity штука';
    }
    if (last >= 2 &&
        last <= 4 &&
        !(quantity % 100 >= 11 && quantity % 100 <= 19)) {
      return '$quantity штуки';
    } else {
      return '$quantity штук';
    }
  }
  String _adjustedPrice(String price) {
    final intPrice = int.parse(price);
    assert(intPrice > 0);
    int last = intPrice % 10;
    if (last == 1 && !(intPrice % 100 >= 11 && intPrice % 100 <= 19)) {
      return '$intPrice рубль';
    }
    if (last >= 2 &&
        last <= 4 &&
        !(intPrice % 100 >= 11 && intPrice % 100 <= 19)) {
      return '$intPrice рубля';
    } else {
      return '$intPrice рублей';
    }
  }
}
