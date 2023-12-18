import 'package:appda2/ui/home.dart';
import 'package:appda2/ui/homePage.dart';
import 'package:flutter/material.dart';

String hostName = "https://draft.aithings.vn:6889";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
