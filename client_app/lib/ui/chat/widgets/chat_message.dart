import 'package:client_app/classes/message.dart';
import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final Message message;
  final DateTime timeOfMessage;
  ChatMessage({
    this.message,
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
                        AssetImage("assets/mealtime.png"),
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
              child: buildTextOrderMessage(),
            ),
          ],
        ),
      );
    }

    if (!message.needDate) {
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
