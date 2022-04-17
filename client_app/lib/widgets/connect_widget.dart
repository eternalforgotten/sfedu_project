import 'package:client_app/router.dart';
import 'package:client_app/widgets/connectivity_indicator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectWidget extends StatelessWidget {
  final ConnectivityResult initial;
  const ConnectWidget(this.initial, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      initialData: initial,
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        bool connected = snapshot.data != ConnectivityResult.none;
        return ConnectivityIndicator(
          topPosition: connected ? -30 : 35,
        );
      },
    );
  }
}
