import 'package:client_app/responsive_size.dart';
import 'package:client_app/ui/order_verification/agreement.dart';
import 'package:client_app/ui/order_verification/verification_appbar.dart';
import 'package:client_app/ui/order_verification/verification_number_page/widgets/verification_number_text_field.dart';

import 'package:flutter/material.dart';

class VerificationNumberPage extends StatefulWidget {
  @override
  _VerificationNumberPageState createState() => _VerificationNumberPageState();
}

class _VerificationNumberPageState extends State<VerificationNumberPage> {
  final TextEditingController phoneNumber = TextEditingController();

  @override
  void dispose() {
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            VerificationAppbar("Телефон"),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: ResponsiveSize.responsiveWidth(24, context),
                    ),
                    child: Text(
                      "Для оформления заказа введите номер телефона. На него придёт СМС с кодом подтверждения.",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2.color,
                        fontFamily:
                            Theme.of(context).textTheme.bodyText2.fontFamily,
                        fontSize: ResponsiveSize.responsiveHeight(18, context),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(
                    height: ResponsiveSize.responsiveHeight(55, context),
                  ),
                  VerificationNumberTextField(
                    controller: phoneNumber,
                    onSubmitted: phoneNumber.text.isNotEmpty
                        ? (_) {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            Navigator.of(context).pushNamed('/code');
                          }
                        : (_) {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Введите номер телефона'),
                              ),
                            );
                          },
                  ),
                  SizedBox(
                    height: ResponsiveSize.responsiveHeight(59, context),
                  ),
                  GestureDetector(
                    onTap: phoneNumber.text.isNotEmpty
                        ? () {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            Navigator.of(context).pushNamed('/code');
                          }
                        : () {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Введите номер телефона'),
                              ),
                            );
                          },
                    child: Container(
                      width: ResponsiveSize.responsiveWidth(212, context),
                      height: ResponsiveSize.responsiveHeight(52, context),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                      ),
                      child: Center(
                        child: Text(
                          'Далее',
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .fontFamily,
                            color: Colors.white,
                            fontSize: ResponsiveSize.responsiveHeight(
                              18,
                              context,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Agreement(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
