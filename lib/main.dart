// main.dart
import 'package:flutter/material.dart';

import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            repeat: ImageRepeat.repeat,
            image: AssetImage('Image/SFONDO.jpg'),
          )),
      child: GestureDetector(
          onTap: () async {
            await Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) => PageLoginPage(),
              ),
            );
          },
          child: Container(
              width: 10,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFF3285FF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: Text(
                '''Register''',
                textAlign: TextAlign.center,
              ))),
    );
  }
}