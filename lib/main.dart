import 'package:day8/MovieScreen.dart';
import 'package:day8/Wishlist.dart';
import 'package:flutter/material.dart';
import 'home2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/':(context) => MyHomePage(),
        '/MovieScreen':(context) => MovieScreen(),
        '/Wishlist': (context) => Wishlist(),
      },
    );
  }
}
