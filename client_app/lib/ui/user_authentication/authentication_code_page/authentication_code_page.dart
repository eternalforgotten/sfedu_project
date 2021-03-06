import 'package:client_app/business_logic/auth_bloc/auth_bloc.dart';
import 'package:client_app/business_logic/chat_bloc/chat_bloc.dart';
import 'package:client_app/responsive_size.dart';
import 'package:client_app/simple_snack_bar.dart';
import 'package:client_app/ui/user_authentication/authentication_code_page/widgets/enter_code_text_field.dart';
import 'package:client_app/ui/user_authentication/verification_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCodePage extends StatelessWidget {
  final bool needAction;
  final String page;
  AuthenticationCodePage({
    @required this.page,
    this.needAction = false,
  });
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          showSimpleSnackBar(context, text: state.message);
        }
        if (state is UserAuthenticatedState) {
          BlocProvider.of<ChatBloc>(context)
              .add(FetchChatEvent(state.userPhone));
          Navigator.pushNamedAndRemoveUntil(
            context,
            page,
            (r) => r.isFirst,
            arguments: state.userPhone,
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
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
