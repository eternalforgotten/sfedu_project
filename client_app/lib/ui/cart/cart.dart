import 'package:client_app/ui/item_page/widgets/pop_back_button.dart';
import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';

import 'widgets.dart/list_of_dishes.dart';
import 'widgets.dart/navbar.dart';
import 'widgets.dart/title_block.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                          top: ResponsiveSize.responsiveHeight(20, context),
                          bottom: ResponsiveSize.responsiveHeight(24, context),
                        ),
                        child: PopBackButton(),
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
      ),
    );
  }
}
