import 'package:client_app/responsive_size.dart';
import 'package:client_app/ui/order_verification/agreement.dart';
import 'package:client_app/ui/order_verification/verification_appbar.dart';
import 'package:client_app/ui/order_verification/verification_code_page/widgets/enter_code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class VerificationCodePage extends StatelessWidget {
  final CountdownController countdownController = CountdownController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: Column(
            children: [
              VerificationAppbar("Код подтверждения"),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ResponsiveSize.responsiveWidth(24, context),
                      ),
                      child: Text(
                        "Мы отправили Вам код подтверждения на указанный ранее номер телефона",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2.color,
                          fontFamily:
                              Theme.of(context).textTheme.bodyText2.fontFamily,
                          fontSize:
                              ResponsiveSize.responsiveHeight(18, context),
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveSize.responsiveHeight(55, context),
                    ),
                    EnterCodeTextField(),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ResponsiveSize.responsiveWidth(24, context),
                      ),
                      child: Countdown(
                          controller: countdownController,
                          onFinished: () {},
                          seconds: 90,
                          build: (context, time) {
                            int minutes = time.toInt() ~/ 60;
                            String seconds = time.toInt() % 60 < 10
                                ? "0" + (time.toInt() % 60).toString()
                                : (time.toInt() % 60).toString();
                            return Text(
                              "Получить новый код можно через 0$minutes:$seconds",
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.bodyText2.color,
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .fontFamily,
                                fontSize: ResponsiveSize.responsiveHeight(
                                    18, context),
                              ),
                              textAlign: TextAlign.center,
                            );
                          }),
                    ),
                    SizedBox(
                      height: ResponsiveSize.responsiveHeight(15, context),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal:
                              ResponsiveSize.responsiveWidth(24, context),
                        ),
                        child: Text(
                          "Получить новый код",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .fontFamily,
                            fontSize:
                                ResponsiveSize.responsiveHeight(18, context),
                          ),
                          textAlign: TextAlign.center,
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
      ),
    );
  }
}
