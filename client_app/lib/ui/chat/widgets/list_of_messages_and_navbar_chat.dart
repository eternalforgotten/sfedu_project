import 'package:client_app/business_logic/chat_bloc/chat_bloc.dart';
import 'package:client_app/ui/chat/widgets/chat_message.dart';
import 'package:client_app/classes/message.dart';
import 'package:client_app/responsive_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListOfMessagesAndNavbarChat extends StatefulWidget {
  @override
  _ListOfMessagesAndNavbarChatState createState() =>
      _ListOfMessagesAndNavbarChatState();
}

class _ListOfMessagesAndNavbarChatState
    extends State<ListOfMessagesAndNavbarChat> {
  TextEditingController textEditingController = TextEditingController();
  ScrollController _controller = ScrollController();
  RefreshController _refreshController = RefreshController();
  bool _isMessageEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              top: ResponsiveSize.responsiveHeight(5, context),
            ),
            height: ResponsiveSize.responsiveHeight(576, context),
            child: SmartRefresher(
              enablePullUp: true,
              enablePullDown: false,
              reverse: true,
              footer: CustomFooter(
                builder: (context, mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("");
                  } else if (mode == LoadStatus.loading) {
                    body = CircularProgressIndicator.adaptive(
                      backgroundColor: Theme.of(context).accentColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    );
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: ResponsiveSize.responsiveHeight(50, context),
                    child: Center(child: body),
                  );
                },
              ),
              header: null,
              controller: _refreshController,
              onLoading: () async {
                _refreshController.loadComplete();
              },
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc('89184735828')
                    .snapshots(),
                builder: (ctx, snap) {
                  var hasData = snap.hasData;
                  var map =
                      hasData ? snap.data.data() as Map<String, Object> : null;
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: hasData && map != null
                          ? (map['messages'] as List<dynamic>)
                              .map(
                                (raw) => Message.fromJson(
                                  raw as Map<String, Object>,
                                ),
                              )
                              .map(
                                (msg) => ChatMessage(
                                  message: msg,
                                ),
                              )
                              .toList()
                          : [],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Container(
          width: ResponsiveSize.responsiveWidth(360, context),
          padding: EdgeInsets.only(
            left: ResponsiveSize.responsiveWidth(10, context),
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: ResponsiveSize.responsiveHeight(40, context),
                    width: ResponsiveSize.responsiveHeight(40, context),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: GestureDetector(
                        //отправка изображения
                        onTap: () async {},
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: ResponsiveSize.responsiveHeight(18, context),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: ResponsiveSize.responsiveWidth(230, context),
                    child: TextField(
                      onChanged: (_) {
                        setState(() {
                          _isMessageEmpty = textEditingController.text.isEmpty;
                        });
                      },
                      textCapitalization: TextCapitalization.sentences,
                      minLines: 1,
                      maxLines: 4,
                      controller: textEditingController,
                      textInputAction: TextInputAction.newline,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Введите сообщение...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyText2.color,
                          fontFamily:
                              Theme.of(context).textTheme.bodyText2.fontFamily,
                          fontSize:
                              ResponsiveSize.responsiveHeight(16, context),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    //отправка сообщения
                    onTap: !_isMessageEmpty
                        ? () {
                            BlocProvider.of<ChatBloc>(context).add(
                              SendMessageEvent(
                                Message(
                                  content: textEditingController.text,
                                  sender: "User",
                                  time: DateTime.now(),
                                ),
                                '89184735828',
                              ),
                            );
                            textEditingController.text = "";
                            setState(() {
                              _isMessageEmpty = true;
                            });
                          }
                        : null,
                    child: Container(
                      width: ResponsiveSize.responsiveWidth(50, context),
                      height: ResponsiveSize.responsiveHeight(40, context),
                      decoration: BoxDecoration(
                        color: _isMessageEmpty
                            ? Colors.grey
                            : Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.send,
                          size: ResponsiveSize.responsiveHeight(21, context),
                          color: _isMessageEmpty ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
