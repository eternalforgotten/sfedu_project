import 'package:client_app/business_logic/auth_bloc/auth_bloc.dart';
import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        FocusScope.of(context).unfocus();
        bool result = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Вы точно хотите выйти из аккаунта?'),
              actions: [
                TextButton(
                  onPressed: (){
                    Navigator.of(ctx).pop(true);
                  },
                  child: Text('Да'),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.of(ctx).pop(false);
                  },
                  child: Text('Нет'),
                ),
              ],
            );
          },
        );
        if (result != null && result){
          BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
        }
      },
      child: Container(
        height: ResponsiveSize.responsiveHeight(40, context),
        width: ResponsiveSize.responsiveWidth(54, context),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xFFD3DADD),
            width: 0.5,
          ),
        ),
        child: Icon(
          Icons.logout,
          size: ResponsiveSize.responsiveHeight(19, context),
          color: Colors.white,
        ),
      ),
    );
  }
}
