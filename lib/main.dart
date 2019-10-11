import 'package:flutter/material.dart';
import 'package:gerente_loja/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desapega Jipa',
      theme: ThemeData(
        primaryColor: Colors.teal
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}