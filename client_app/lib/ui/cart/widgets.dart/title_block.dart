import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';

class TitleBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsLength = [].length.toString();
    String _correctWord() {
      if (goodsLength.endsWith("1") && goodsLength != "11")
        return "товар";
      else if (goodsLength.length > 1 &&
              goodsLength[goodsLength.length - 2] == "1" ||
          goodsLength.endsWith("0") ||
          goodsLength.endsWith("5") ||
          goodsLength.endsWith("6") ||
          goodsLength.endsWith("7") ||
          goodsLength.endsWith("8") ||
          goodsLength.endsWith("9"))
        return "товаров";
      else
        return "товара";
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Мой заказ',
            style: TextStyle(
              fontSize: ResponsiveSize.responsiveHeight(32, context),
              color: Theme.of(context).textTheme.bodyText1.color,
              fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$goodsLength ${_correctWord()}',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText2.color,
              fontFamily: Theme.of(context).textTheme.bodyText2.fontFamily,
              fontSize: ResponsiveSize.responsiveHeight(18, context),
            ),
          ),
        ],
      ),
    );
  }
}
