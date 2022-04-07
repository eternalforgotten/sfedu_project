import 'package:client_app/business_logic/cart_bloc/cart_bloc.dart';
import 'package:client_app/repos/repo.dart';
import 'package:client_app/responsive_size.dart';
import 'package:client_app/ui/main_menu_page/main_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class EnterCodeTextField extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveSize.responsiveHeight(220, context),
      child: PinCodeTextField(
        appContext: context,
        onChanged: (_) {},
        controller: controller,
        length: 4,
        onCompleted: (text) {
          BlocProvider.of<CartBloc>(context).add(ClearEvent());
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        pinTheme: PinTheme(
          activeColor: Color(0xFFE2E2E2),
          inactiveColor: Color(0xFFE2E2E2),
          selectedColor: Color(0xFFE2E2E2),
          shape: PinCodeFieldShape.box,
          fieldHeight: ResponsiveSize.responsiveHeight(52, context),
          fieldWidth: ResponsiveSize.responsiveWidth(40, context),
          borderRadius: BorderRadius.circular(10),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
