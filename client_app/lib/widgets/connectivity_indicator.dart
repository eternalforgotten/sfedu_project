import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';

class ConnectivityIndicator extends StatelessWidget {
  final double topPosition;
  const ConnectivityIndicator({@required this.topPosition, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: topPosition,
      duration: const Duration(milliseconds: 200),
      child: Container(
        height: 30,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        color: Colors.red,
        child: Card(
          elevation: 0,
          color: Colors.red,
          child: Text(
            'Отсутствует подключение к интернету',
            style: TextStyle(
              color: Colors.white,
              fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
              fontSize: ResponsiveSize.responsiveHeight(
                15,
                context,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
