import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';

class PopBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: ResponsiveSize.responsiveHeight(40, context),
        width: ResponsiveSize.responsiveHeight(40, context),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFD3DADD),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        child: Icon(Icons.keyboard_arrow_left),
      ),
    );
  }
}
