import 'package:client_app/ui/order_info/widgets/create_order_button.dart';
import 'package:client_app/ui/order_info/widgets/order_info_widget.dart';
import 'package:client_app/widgets/appbar_chat.dart';
import 'package:flutter/material.dart';

class OrderInfoPage extends StatelessWidget {
  const OrderInfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppbar('Информация о заказе'),
            OrderInfoWidget(),
            CreateOrderButton(),
          ],
        ),
      ),
    );
  }
}
