import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveSize.responsiveHeight(48, context),
      width: ResponsiveSize.responsiveWidth(312, context),
      padding: EdgeInsets.only(
        left: ResponsiveSize.responsiveWidth(18, context),
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF2F3F4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Icon(
              Icons.search,
              size: ResponsiveSize.responsiveHeight(20, context),
            ),
          ),
          SizedBox(
            width: ResponsiveSize.responsiveWidth(15, context),
          ),
          Container(
            width: ResponsiveSize.responsiveWidth(220, context),
            height: ResponsiveSize.responsiveHeight(40, context),
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                hintText: "Поиск",
                hintStyle: TextStyle(
                  fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
                  fontSize: ResponsiveSize.responsiveHeight(15, context),
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
          GestureDetector(
            child: Icon(
              Icons.close,
              size: ResponsiveSize.responsiveHeight(20, context),
            ),
          ),
        ],
      ),
    );
  }
}
