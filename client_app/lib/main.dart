import 'package:client_app/business_logic/cart_bloc/cart_bloc.dart';
import 'package:client_app/repos/repo.dart';
import 'package:client_app/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final firebase = FirebaseFirestore.instance;
  final cartRepo = CartRepository();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(cartRepo),
      child: MaterialApp(
        title: 'MealTime',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Color(0xFFFA7022),
          accentColor: Color(0xFF0C2944),
          cardColor: Color(0xFFF5F7FE),
        ),
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
