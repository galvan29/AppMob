import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:lottie/lottie.dart';

class FirstPage2 extends StatefulWidget {
  const FirstPage2({Key? key}) : super(key: key);

  @override
  State<FirstPage2> createState() => _FirstPage2State();
}

class _FirstPage2State extends State<FirstPage2>
    with TickerProviderStateMixin {
  late AnimationController? _animController;
  bool isAnimFinis = false;
  bool isTextReady = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this);
    _animController!.addListener(() {
      if (_animController!.value >= 1) {
        _animController!.stop();
        isAnimFinis = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          isTextReady = true;
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animController?.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: isAnimFinis ? screenHeight / 1.4 : screenHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(isAnimFinis ? 40.0 : 0.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: !isAnimFinis,
                  child: Lottie.asset(
                    'assets/json/a.json',
                    height: screenHeight * 0.85,
                    controller: _animController,
                    onLoaded: (composition) {
                      _animController!
                        ..duration = composition.duration
                        ..forward();
                    },
                  ),
                ),
                Visibility(
                  visible: isAnimFinis,
                  child: Image.asset(
                    'assets/image/logoGym.png',
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                    opacity: isTextReady ? 1 : 0,
                    duration: const Duration(seconds: 1),
                      child: Column(
                        children: [
                          Text(
                            'MyTraining',
                            style: GoogleFonts.adventPro(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 60,
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            'Schedule your training',
                            style: GoogleFonts.adventPro(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 30,
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ],
                      )),
                  ),
              ],
            ),
          ),

          // Text bottom part
          Visibility(visible: isAnimFinis, child: const _BottomPart()),
        ],
      ),
    );
  }
}


@override
class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
        child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                margin: const EdgeInsets.only(
                  left: 50,
                  top: 20,
                  right: 50,
                ),
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(),
                child: GestureDetector(
                  onTap: () {
                    utentiModel.setStackIndex(1);
                  },
                  child: Container(
                      width: double.maxFinite,
                      height: 40,
                      padding: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          border: Border.all(color: Colors.white)),
                      child: Text(
                        '''Login''',
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      )),
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
                  onTap: () {
                    utentiModel.utenteBeingEdited = Utente();
                    utentiModel.setStackIndex(2);
                  },
                  child: Container(
                      width: 10,
                      height: 40,
                      padding: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          border: Border.all(color: Colors.white)),
                      child: Text(
                        '''Register''',
                        style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ))),
            ),
          ],
        ),
        )
    );
  }
}