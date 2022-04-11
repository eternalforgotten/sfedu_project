import 'package:client_app/ui/chat/widgets/chat_message.dart';
import 'package:client_app/classes/message.dart';
import 'package:client_app/responsive_size.dart';
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

  List<ChatMessage> _listOfMessages = [];
  //Список всех сообщений-виджетов

  bool historyLoad = false; // индикатор загрузки истории
  bool shouldAdd(Message msg) {
    return msg.sender != "System" && msg.type != TypeMessage.temp;
  }

  bool needDate(Message msg, bool onMessage) {
    return onMessage
        ? (_listOfMessages.isEmpty ||
            msg.time.day != _listOfMessages.last.message.time.day)
        : (_listOfMessages.isNotEmpty &&
            msg.time.day != _listOfMessages.last.message.time.day);
  }

  void addMessage(String text, {bool onMessage = false}) {
    setState(() {
      var msg = Message(
          time: DateTime.now(),
          sender: "User",
          type: TypeMessage.text,
          content: text);
      _listOfMessages.add(
        ChatMessage(
          message: msg,
          date: needDate(msg, onMessage),
        ),
      );
    });
  }

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
              enablePullUp: true, //
              enablePullDown: false,
              reverse: true, //
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
              child: ListView.builder(
                controller: _controller,
                itemCount: _listOfMessages.length,
                itemBuilder: (c, i) =>
                    _listOfMessages[_listOfMessages.length - 1 - i],
              ),
            ),
          ),
        ),
        Container(
          width: ResponsiveSize.responsiveWidth(360, context),
          padding: EdgeInsets.only(
            left: ResponsiveSize.responsiveWidth(10, context),
          ),
          child: Row(
            //навбвр чата - выбор картинки, текстовое поле, кнопка отправки ссообщения
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
                  //поле для ввода сообщения
                  // keyboardType: TextInputType.text,
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
                      fontSize: ResponsiveSize.responsiveHeight(16, context),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                //отправка сообщения
                onTap: () {
                  if (textEditingController.value.text.trim().isNotEmpty) {
                    addMessage(textEditingController.value.text);
                    textEditingController.text = "";
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      //говорим, что нужно вызвать функцию
                      //после выполения метода build() - иначе не заработает
                      setState(() {
                        _controller.animateTo(
                            0, //прокручиваем вниз до самого последнего сообщения
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeInCubic);
                      });
                    });
                  }
                },
                child: Container(
                  width: ResponsiveSize.responsiveWidth(50, context),
                  height: ResponsiveSize.responsiveHeight(40, context),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.send,
                      size: ResponsiveSize.responsiveHeight(21, context),
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
