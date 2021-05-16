import 'package:client_app/UI/item_page/widgets/pop_back_button.dart';
import 'package:client_app/responsive_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets.dart/list_of_dishes.dart';
import 'widgets.dart/navbar.dart';
import 'widgets.dart/title_block.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 89,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: ResponsiveSize.responsiveWidth(24, context),
                        top: ResponsiveSize.responsiveHeight(45, context),
                        bottom: ResponsiveSize.responsiveHeight(24, context),
                      ),
                      child: PopBackButton(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: ResponsiveSize.responsiveWidth(24, context),
                        top: ResponsiveSize.responsiveHeight(45, context),
                        bottom: ResponsiveSize.responsiveHeight(24, context),
                      ),
                      child: Container(
                        height: ResponsiveSize.responsiveHeight(40, context),
                        width: ResponsiveSize.responsiveHeight(40, context),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                          size: ResponsiveSize.responsiveHeight(19, context),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: ResponsiveSize.responsiveWidth(24, context),
                    bottom: ResponsiveSize.responsiveHeight(16, context),
                  ),
                  child: TitleBlock(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: ResponsiveSize.responsiveWidth(24, context),
                  ),
                  child: ListOfDishes(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 11,
            child: Navbar(),
          ),
        ],
      ),
    );
  }
}