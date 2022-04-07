import 'package:client_app/responsive_size.dart';
import 'package:client_app/ui/cart/cart.dart';
import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus();

        await Navigator.of(context)
            .pushNamed('/cart');
      },
      child: Container(
        height: ResponsiveSize.responsiveHeight(40, context),
        width: ResponsiveSize.responsiveWidth(54, context),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.shopping_cart_outlined,
          size: ResponsiveSize.responsiveHeight(24, context),
          color: Colors.white,
        ),
      ),
    );
  }
}
