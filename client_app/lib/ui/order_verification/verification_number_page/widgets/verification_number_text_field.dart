import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class VerificationNumberTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String) onSubmitted;

  VerificationNumberTextField({
    @required this.controller,
    this.onSubmitted,
  });

  @override
  _VerificationNumberTextFieldState createState() =>
      _VerificationNumberTextFieldState();
}

class _VerificationNumberTextFieldState
    extends State<VerificationNumberTextField> {
  FocusNode _focusNode = FocusNode();
  

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  var maskPhone = MaskTextInputFormatter(mask: "+7(###)###-##-##");
  var flag = true;
  @override
  Widget build(BuildContext context) {
    if (flag && _focusNode.hasFocus) {
      widget.controller.text = "+7";
      widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.controller.text.length),
      );
      flag = false;
    }
    return Container(
      margin: EdgeInsets.only(
        right: ResponsiveSize.responsiveWidth(20, context),
        left: ResponsiveSize.responsiveWidth(20, context),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
      ),
      width: ResponsiveSize.responsiveWidth(320, context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: ResponsiveSize.responsiveWidth(56, context),
            height: ResponsiveSize.responsiveHeight(40, context),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            child: Icon(
              Icons.person,
              size: ResponsiveSize.responsiveHeight(26, context),
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: ResponsiveSize.responsiveWidth(14, context),
          ),
          Container(
            width: ResponsiveSize.responsiveWidth(230, context),
            child: Form(
              child: TextFormField(
                onFieldSubmitted: widget.onSubmitted,
                focusNode: _focusNode,
                keyboardType: TextInputType.phone,
                controller: widget.controller,
                inputFormatters: [maskPhone],
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
                  fontSize: ResponsiveSize.responsiveHeight(17, context),
                ),
                cursorColor: Theme.of(context).textTheme.bodyText1.color,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: "Номер телефона",
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2.color,
                    fontFamily:
                        Theme.of(context).textTheme.bodyText2.fontFamily,
                    fontSize: ResponsiveSize.responsiveHeight(17, context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
