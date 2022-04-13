import 'package:bloc/bloc.dart';
import 'package:client_app/classes/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Message> _userMessages = [];
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  ChatBloc() : super(ChatInitial()) {
    on<FetchChatEvent>(_onUserChatFetch);
    on<SendMessageEvent>(_onSendMessage);
  }
  Future<void> _onUserChatFetch(FetchChatEvent event, Emitter emit) async {
    var userChat =
        await _firebaseFirestore.collection('chats').doc(event.number).get();
    var rawMessages = userChat.data()['messages'] as List<dynamic>;
    List<Message> messages = [];
    rawMessages.forEach((rawMessage) {
      final data = rawMessage as Map<String, Object>;
      final message = Message.fromJson(data);
      messages.add(message);
    });
    _userMessages = messages;
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter emit) async {
    final number = event.number;
    final sentMessage = event.message;
    var userChat =
        await _firebaseFirestore.collection('chats').doc(number).get();
    var rawMessages = userChat.data()['messages'] as List<dynamic>;
    var addedMessage = Message(
      time: sentMessage.time,
      sender: sentMessage.sender,
      content: sentMessage.content,
      needDate: _needDate(sentMessage),
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
  }

  bool _needDate(Message msg) {
    bool isFirstMsg = _userMessages.isEmpty;
    bool areDaysDiffer = _userMessages.last.time.day != msg.time.day;
    return isFirstMsg || areDaysDiffer;
  }
}
