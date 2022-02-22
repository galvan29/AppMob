// main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'register.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Stack(
        children: [
          Stack(
            children: [
              Image.network(
                r'''https://i.pinimg.com/736x/fd/51/40/fd5140c875e584cb8cc7063a6469c19b.jpg''',
                width: double.maxFinite,
                height: double.maxFinite,
                fit: BoxFit.cover,
              ),
              Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.48,
                      ),
                      padding: EdgeInsets.zero,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(),
                      child: Text(r'''MyTraining''',
                          style: GoogleFonts.adventPro(
                            textStyle: TextStyle(
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w400,
                              fontSize: 50,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      padding: EdgeInsets.zero,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(),
                      child: Text(r'''Schedule your training''',
                          style: GoogleFonts.adventPro(
                            textStyle: TextStyle(
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w400,
                              fontSize: 25,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 50,
                        top: 100,
                        right: 50,
                      ),
                      padding: EdgeInsets.zero,
                      decoration: const BoxDecoration(),
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
                              width: double.maxFinite,
                              height: 40,
                              padding: EdgeInsets.only(top:8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.05),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                  border: Border.all(color: Colors.white)
                              ),
                              child: Text(
                                '''Login''',
                                style: GoogleFonts.adventPro(
                                  textStyle: TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              )
                                ),
                          )),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 50,
                        top: 10,
                        right: 50,
                      ),
                      padding: EdgeInsets.zero,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(),
                      child: GestureDetector(
                          onTap: () async {
                            await Navigator.push<void>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PageRegisterPage(),
                              ),
                            );
                          },
                          child: Container(
                              width: 10,
                              height: 40,
                              padding: EdgeInsets.only(top:8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.05),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                  border: Border.all(color: Colors.white)
                              ),
                              child: Text(
                                '''Register''',
                                style: GoogleFonts.adventPro(
                                  textStyle: TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}