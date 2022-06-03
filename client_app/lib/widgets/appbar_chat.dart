import 'package:client_app/ui/item_page/widgets/pop_back_button.dart';
import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;

  CustomAppbar(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: ResponsiveSize.responsiveWidth(24, context),
        right: ResponsiveSize.responsiveWidth(27, context),
        bottom: ResponsiveSize.responsiveHeight(15, context),
        top: ResponsiveSize.responsiveHeight(10, context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PopBackButton(),
          Text(
            title,
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
              color: Theme.of(context).textTheme.bodyText1.color,
              fontSize: ResponsiveSize.responsiveHeight(21, context),
            ),
          ),
        ],
      ),
    );
  }
}
