import 'package:client_app/business_logic/auth_bloc/auth_bloc.dart';
import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpperIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: ResponsiveSize.responsiveWidth(24, context),
        right: ResponsiveSize.responsiveWidth(24, context),
        top: ResponsiveSize.responsiveHeight(10, context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              FocusScope.of(context).unfocus();
              if (BlocProvider.of<AuthBloc>(context).currentUser == null) {
                Navigator.of(context).pushNamed('/phone');
              } else {
                Navigator.of(context).pushNamed('/chat');
              }
            },
            child: Container(
              height: ResponsiveSize.responsiveHeight(40, context),
              width: ResponsiveSize.responsiveHeight(40, context),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFD3DADD),
                  width: 0.5,
                ),
              ),
              child: Icon(
                Icons.message,
                size: ResponsiveSize.responsiveHeight(19, context),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.of(context).pushNamed('/cart');
            },
            child: Container(
              height: ResponsiveSize.responsiveHeight(40, context),
              width: ResponsiveSize.responsiveWidth(54, context),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.shopping_cart_outlined, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
