import 'package:client_app/ui/chat/widgets/appbar_chat.dart';
import 'package:client_app/ui/chat/widgets/list_of_messages_and_navbar_chat.dart';

import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              AppbarChat(),
              Expanded(child: ListOfMessagesAndNavbarChat()),
            ],
          ),
        ),
      ),
    );
  }
}
