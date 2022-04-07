import 'package:client_app/added_dish_snackbar.dart';
import 'package:client_app/business_logic/cart_bloc/cart_bloc.dart';
import 'package:client_app/repos/repo.dart';
import 'package:client_app/responsive_size.dart';
import 'package:client_app/ui/order_verification/verification_number_page/verification_number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: ResponsiveSize.responsiveWidth(25, context),
      ),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          var sum = 0;
          if (state is CartChangedState) {
            sum = state.totalSum;
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Итого:',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2.color,
                      fontFamily:
                          Theme.of(context).textTheme.bodyText2.fontFamily,
                      fontSize: ResponsiveSize.responsiveHeight(16, context),
                    ),
                  ),
                  Text(
                    sum.toString() + " р",
                    style: GoogleFonts.roboto(
                      fontSize: ResponsiveSize.responsiveHeight(20, context),
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<CartBloc>(context).cart.cart.isNotEmpty
                      ? Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => VerificationNumberPage(),
                          ),
                        )
                      : ScaffoldMessenger.of(context).showSnackBar(
                          simpleSnackBar("Добавьте блюда в корзину!"),
                        );
                },
                child: Container(
                  width: ResponsiveSize.responsiveWidth(220, context),
                  height: ResponsiveSize.responsiveHeight(52, context),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        ResponsiveSize.responsiveWidth(10, context),
                      ),
                      bottomLeft: Radius.circular(
                        ResponsiveSize.responsiveWidth(10, context),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Заказать',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ResponsiveSize.responsiveWidth(18, context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
