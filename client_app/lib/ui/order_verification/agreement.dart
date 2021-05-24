import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';

class Agreement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.responsiveWidth(25, context),
      ),
      margin: EdgeInsets.only(
        bottom: ResponsiveSize.responsiveHeight(9, context),
      ),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {},
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "При входе или регистрации вы принимаете условия ",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2.color,
                  fontFamily: Theme.of(context).textTheme.bodyText2.fontFamily,
                  fontSize: ResponsiveSize.responsiveHeight(14, context),
                ),
              ),
              TextSpan(
                text: "пользовательского соглашения.",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
                  fontSize: ResponsiveSize.responsiveHeight(14, context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
