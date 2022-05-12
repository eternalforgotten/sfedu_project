import 'package:client_app/business_logic/auth_bloc/auth_bloc.dart';
import 'package:client_app/business_logic/cart_bloc/cart_bloc.dart';
import 'package:client_app/business_logic/chat_bloc/chat_bloc.dart';
import 'package:client_app/business_logic/dish_bloc/dish_bloc.dart';
import 'package:client_app/repos/repo.dart';
import 'package:client_app/router.dart';
import 'package:client_app/widgets/connect_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

bool FIRST = true;

class MyApp extends StatelessWidget {
  final firebase = FirebaseFirestore.instance;

  final cartRepo = CartRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DishBloc(FirebaseFirestore.instance)
            ..add(
              FetchEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => CartBloc(cartRepo),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
         BlocProvider(
          create: (context) => ChatBloc(),
        ),
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          alignment: Alignment.center,
          children: [
            MaterialApp(
              title: 'MealTime',
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primaryColor: Color(0xFFFA7022),
                accentColor: Color(0xFF0C2944),
                cardColor: Color(0xFFF5F7FE),
              ),
              onGenerateRoute: onGenerateRoute,
            ),
            FutureBuilder<ConnectivityResult>(
              future: Connectivity().checkConnectivity(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox.shrink();
                }
                return ConnectWidget(snapshot.data);
              },
            ),
          ],
        ),
      ),
    );
  }
}
