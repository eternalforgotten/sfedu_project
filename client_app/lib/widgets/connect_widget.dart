import 'package:client_app/router.dart';
import 'package:client_app/widgets/connectivity_indicator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectWidget extends StatelessWidget {
  const ConnectWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Navigator(
          onGenerateRoute: onGenerateRoute,
        ),
        StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            bool connected;
            if (snapshot.data == ConnectivityResult.none){
              connected = false;
            }
            else {
              connected = true;
            }
            return ConnectivityIndicator(
              topPosition: connected ? -30 : 35,
            );
          },
        ),
      ],
    );
  }
}
