import 'package:flutter/material.dart';

void showSimpleSnackBar(
  BuildContext context, {
  @required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
