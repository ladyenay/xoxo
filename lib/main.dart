import 'package:flutter/material.dart';
import 'pages/menu_page.dart';

void main() {
  runApp(const XoxOGame());
}

class XoxOGame extends StatelessWidget {
  const XoxOGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XoxO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MenuPage(),
    );
  }
}
