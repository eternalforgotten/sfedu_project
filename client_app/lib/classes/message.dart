import 'package:flutter/material.dart';

class Message {
  final DateTime time;
  final String sender;
  final TypeMessage type;
  final String content;
  final String price;

  const Message(
      {@required this.time,
      @required this.sender,
      @required this.type,
      @required this.content,
      this.price = '0'});

  void printMessage() {
    print('time is $time');
    print('sender is $sender');
    print('type is $type');
    print('content is $content');
  }
  
}

enum TypeMessage{
  text, picture, order, temp, bill
}
extension ValueGetter on TypeMessage{
  
  int get typeIndex => this.index+ 1;
}
