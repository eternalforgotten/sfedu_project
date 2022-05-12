import 'package:client_app/business_logic/auth_bloc/auth_bloc.dart';
import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EnterCodeTextField extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthBloc>(context);
    return Container(
      width: ResponsiveSize.responsiveHeight(270, context),
      child: PinCodeTextField(
        appContext: context,
        onChanged: (_) {},
        controller: controller,
        length: 6,
        onCompleted: (text) {
          final id = bloc.verificationId;
          if (id != null){
            bloc.add(SendCodeEvent(text, id));
          }
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
