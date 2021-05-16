import 'package:client_app/classes/message.dart';
import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMessage extends StatelessWidget {
  final Message message;
  final bool date;
  final DateTime timeOfMessage;
  ChatMessage({
    this.message,
    this.date = false,
  }) : this.timeOfMessage = message.time;

  @override
  Widget build(BuildContext context) {
    var minutes = message.time.minute;
    var displayedMinutes = minutes >= 0 && minutes <= 9
        ? "0" + minutes.toString()
        : minutes.toString();
    var hours = message.time.hour;
    var displayedHours =
        hours >= 0 && hours <= 9 ? "0" + hours.toString() : hours.toString();
    String _getMonth() {
      switch (message.time.month) {
        case 1:
          return 'Января';
          break;
        case 2:
          return 'Февраля';
          break;
        case 3:
          return 'Марта';
          break;
        case 4:
          return 'Апреля';
          break;
        case 5:
          return 'Мая';
          break;
        case 6:
          return 'Июня';
          break;
        case 7:
          return 'Июля';
          break;
        case 8:
          return 'Августа';
          break;
        case 9:
          return 'Сентября';
          break;
        case 10:
          return 'Октября';
          break;
        case 11:
          return 'Ноября';
          break;
        default:
          return 'Декабря';
      }
    }

    Widget _getTime({bool flag = false}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            displayedHours + ':',
            style: TextStyle(
              fontSize: ResponsiveSize.responsiveHeight(10, context),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              color: flag
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyText2.color,
            ),
          ),
          Text(
            displayedMinutes,
            style: TextStyle(
              fontSize: ResponsiveSize.responsiveHeight(10, context),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              color: flag
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyText2.color,
            ),
          ),
        ],
      );
    }

    Widget buildBillMessage() {
      return Container(
        padding: EdgeInsets.only(
          right: ResponsiveSize.responsiveWidth(6, context),
          left: ResponsiveSize.responsiveWidth(9, context),
          top: ResponsiveSize.responsiveHeight(4, context),
          bottom: ResponsiveSize.responsiveHeight(5, context),
        ),
        constraints: BoxConstraints(
          maxWidth: ResponsiveSize.responsiveWidth(250, context),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Счет на оплату: ${message.price.split('.').first} ",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontFamily:
                        Theme.of(context).textTheme.bodyText1.fontFamily,
                    fontSize: ResponsiveSize.responsiveHeight(18, context),
                  ),
                ),
                TextSpan(
                  text: "₽",
                  style: GoogleFonts.roboto(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontSize: ResponsiveSize.responsiveHeight(18, context),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: ResponsiveSize.responsiveHeight(10, context),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: ResponsiveSize.responsiveWidth(185, context),
                  child: RaisedButton(
                    highlightColor: Colors.white,
                    splashColor: Colors.white,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        color: Color(0xFFA1E8B1),
                        width: 2,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Оплатить",
                      style: TextStyle(
                        color: Color(0xFFA1E8B1),
                        fontSize: ResponsiveSize.responsiveHeight(18, context),
                        fontFamily:
                            Theme.of(context).textTheme.bodyText1.fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                _getTime(),
              ],
            )
          ],
        ),
      );
    }

    Widget buildTextOrderMessage() {
      return Container(
        padding: EdgeInsets.only(
          right: ResponsiveSize.responsiveWidth(6, context),
          left: ResponsiveSize.responsiveWidth(9, context),
          top: ResponsiveSize.responsiveHeight(4, context),
          bottom: ResponsiveSize.responsiveHeight(5, context),
        ),
        constraints: BoxConstraints(
          maxWidth: ResponsiveSize.responsiveWidth(275, context),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: ResponsiveSize.responsiveWidth(219, context),
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  fontSize: ResponsiveSize.responsiveHeight(18, context),
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
            ),
            SizedBox(
              width: ResponsiveSize.responsiveWidth(5, context),
            ),
            _getTime(),
          ],
        ),
      );
    }

    Widget buildPictureMessage() {
      return GestureDetector(
        //если сообщение - картинка
        onTap: () {
          FocusScope.of(context).unfocus();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Hero(
                  tag: message.content + message.time.toString(),
                  child: Card(
                    child: Image.network(
                      message.content,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Hero(
              tag: message.content + message.time.toString(),
              child: Container(
                height: ResponsiveSize.responsiveHeight(210, context),
                width: ResponsiveSize.responsiveWidth(265, context),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ResizeImage(
                      NetworkImage(message.content),
                      width:
                          ResponsiveSize.responsiveWidth(400, context).round(),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                right: ResponsiveSize.responsiveWidth(7, context),
                bottom: ResponsiveSize.responsiveHeight(1, context),
              ),
              margin: EdgeInsets.only(
                right: ResponsiveSize.responsiveWidth(10, context),
                bottom: ResponsiveSize.responsiveHeight(10, context),
              ),
              width: ResponsiveSize.responsiveWidth(40, context),
              height: ResponsiveSize.responsiveHeight(20, context),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(5),
              ),
              child: _getTime(flag: true),
            ),
          ],
        ),
      );
    }

    Widget getTypedMessage({TypeMessage type}) {
      if (type == TypeMessage.bill) {
        return buildBillMessage();
      } else if (type == TypeMessage.text || type == TypeMessage.order) {
        return buildTextOrderMessage();
      } else {
        return buildPictureMessage();
      }
    }

    Widget messageWidget() {
      return Container(
        margin: EdgeInsets.only(
          bottom: ResponsiveSize.responsiveHeight(10, context),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: message.sender == 'Superuser'
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: <Widget>[
            message.sender == 'Superuser'
                ? Container(
                    margin: EdgeInsets.only(
                      left: ResponsiveSize.responsiveWidth(3, context),
                    ),
                    child: CircleAvatar(
                      radius: ResponsiveSize.responsiveHeight(25, context),
                      backgroundImage: ResizeImage(
                        AssetImage("assets/images/logo_2.jpg"),
                        height:
                            (ResponsiveSize.responsiveHeight(25, context) * 4)
                                .ceil(),
                        width:
                            (ResponsiveSize.responsiveHeight(25, context) * 4)
                                .ceil(),
                      ),
                    ),
                  )
                : Container(),
            Container(
              margin: EdgeInsets.only(
                right: message.sender == 'User'
                    ? ResponsiveSize.responsiveWidth(15, context)
                    : 0,
                left: message.sender == 'Superuser'
                    ? ResponsiveSize.responsiveWidth(5, context)
                    : 0,
              ),
              child: getTypedMessage(type: message.type),
            ),
          ],
        ),
      );
    }

    if (!date) {
      return messageWidget();
    } else {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: ResponsiveSize.responsiveHeight(10, context),
            ),
            child: Text(
              message.time.day.toString() + " " + _getMonth(),
              style: TextStyle(
                fontSize: ResponsiveSize.responsiveHeight(12, context),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
          ),
          SizedBox(
            height: ResponsiveSize.responsiveHeight(7, context),
          ),
          messageWidget(),
        ],
      );
    }
  }
}
