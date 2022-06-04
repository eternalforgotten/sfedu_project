import 'package:client_app/business_logic/auth_bloc/auth_bloc.dart';
import 'package:client_app/responsive_size.dart';
import 'package:client_app/simple_snack_bar.dart';
import 'package:client_app/ui/user_authentication/agreement.dart';
import 'package:client_app/ui/user_authentication/verification_appbar.dart';
import 'package:client_app/ui/user_authentication/authentication_number_page/widgets/authentication_number_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationNumberPage extends StatefulWidget {
  final String title;
  final bool needAction;
  final String page;

  AuthenticationNumberPage(this.title,
      {@required this.page, this.needAction = false});
  @override
  _AuthenticationNumberPageState createState() =>
      _AuthenticationNumberPageState();
}

class _AuthenticationNumberPageState extends State<AuthenticationNumberPage> {
  final TextEditingController phoneNumber = TextEditingController();

  @override
  void dispose() {
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is NumberSentState) {
          Navigator.of(context).pushNamed(
            '/code',
            arguments: {
              'needAction': widget.needAction,
              'page': widget.page,
            },
          );
        }
        if (state is AuthErrorState) {
          showSimpleSnackBar(context, text: state.message);
        }
      },
      child: SafeArea(
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
                        widget.title,
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
                    VerificationNumberTextField(
                      controller: phoneNumber,
                    ),
                    SizedBox(
                      height: ResponsiveSize.responsiveHeight(59, context),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        BlocProvider.of<AuthBloc>(context)
                            .add(SendNumberEvent(phoneNumber.text.trim()));
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
      ),
    );
  }
}
