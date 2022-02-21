// main.dart
import 'package:flutter/material.dart';

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
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Card(
              elevation: 10,
              color: Colors.white,
              child: Container(
                width: 300,
                height: 300,
                alignment: Alignment.center,
                child:
                Text('www.kindacode.com', style: TextStyle(fontSize: 24)),
              ),
            ),
          )),
    );
  }
}