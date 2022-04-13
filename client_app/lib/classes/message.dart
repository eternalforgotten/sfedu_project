import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  final DateTime time;
  final String sender;
  final String content;
  bool needDate;

  Message({
    @required this.time,
    this.needDate = false,
    @required this.sender,
    @required this.content,
  });

  void printMessage() {
    print('time is $time');
    print('sender is $sender');
    print('content is $content');
  }

  Message.fromJson(Map<String, dynamic> json)
      : time = _dateTimeFromStamp(json),
        sender = json['sender'],
        content = json['content'],
        needDate = json['need_date'];

  static DateTime _dateTimeFromStamp(Map<String, dynamic> json) {
    var timestamp = json['time'] as Timestamp;
    return DateTime.parse(timestamp.toDate().toString());
  }

  Map<String, Object> toJson(){
    return {
      'sender': this.sender,
      'content': this.content,
      'need_date': this.needDate,
      'time': Timestamp.fromDate(this.time),
    };
  }
}
