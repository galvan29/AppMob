import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageLoginPage extends StatefulWidget {
  const PageLoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PageLoginPage> {
  final datasets = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
  }

  @override
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
              Column(
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
                    child: Text(r'''Login''',
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
                      top: 70,
                      right: 50,
                    ),
                    padding: EdgeInsets.zero,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(),
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                      ),
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: Colors.white
                      ),
                      child: TextField(
                        onChanged: (String value) async {},
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          hintText: r'''   Nome Utente''',
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: GoogleFonts.adventPro(
                          textStyle: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        minLines: 1,
                        maxLength: null,
                        obscureText: false,
                        showCursor: true,
                        autocorrect: false,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 50,
                      right: 50,
                    ),
                    padding: EdgeInsets.zero,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(),
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                      ),
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: TextField(
                        onChanged: (String value) async {},
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          hintText: r'''   Password''',
                          contentPadding: const EdgeInsets.only(),
                        ),
                        style: GoogleFonts.adventPro(
                          textStyle: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        minLines: 1,
                        maxLength: null,
                        obscureText: true,
                        showCursor: true,
                        autocorrect: false,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
