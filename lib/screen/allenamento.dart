import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:custom_timer/custom_timer.dart';

class Allenamento extends StatelessWidget {
  final datasets = <String, dynamic>{};
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  final CustomTimerController _controller = new CustomTimerController();


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 180, 212, 250),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      decoration: const BoxDecoration(),
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        top: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Text('MyTraining',
                          style: GoogleFonts.adventPro(
                            textStyle: TextStyle(
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).size.height * 0.03,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 1),
                    ),
                    Container(
                        padding: EdgeInsets.zero,
                        decoration: const BoxDecoration(),
                        margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.03,
                          top: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            //info
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.02,
                              width: MediaQuery.of(context).size.height * 0.02,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                  border: Border.all(color: Colors.black, width: 1)),
                              child: Icon(
                                Icons.info,
                                size: MediaQuery.of(context).size.height * 0.02,
                                color: const Color(0xFF000000),
                              )),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Text(r'''Nome Scheda''',
                    style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        color: Colors.black,
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
                padding: EdgeInsets.zero,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                  child: CustomTimer(
                    controller: _controller,
                    from: Duration(hours: 12),
                    to: Duration(hours: 0),
                    builder: (CustomTimerRemainingTime remaining) {
                      return Text(
                        "${remaining.hours}:${remaining.minutes}:${remaining.seconds}",
                        style: TextStyle(fontSize: 30.0),
                      );
                    },
                  ),
              ),
                  SizedBox(height: 16.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        child: Text("Start"),
                        onPressed: () => _controller.start(),
                        color: Colors.green,
                      ),
                      FlatButton(
                        child: Text("Pause"),
                        onPressed: () => _controller.pause(),
                        color: Colors.blue,
                      ),
                      FlatButton(
                          child: Text("Reset"),
                          onPressed: () => _controller.reset(),
                          color: Colors.red
                      ),
                    ],
                  ),
              ],
            ),
          ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 180, 212, 250),
          selectedItemColor: Colors.white.withOpacity(0.5),
          unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
          selectedFontSize: MediaQuery.of(context).size.height * 0.02,
          unselectedFontSize: MediaQuery.of(context).size.height * 0.02,
          onTap: (value) {
            if (value == 1) {
              utentiModel.setStackIndex(4);
            } else if (value == 2) {
              utentiModel.setStackIndex(5);
            }
          },
          items: [
            BottomNavigationBarItem(
              label: 'Homepage',
              icon: const Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Schede',
              icon: const Icon(Icons.article_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Profilo',
              icon: const Icon(Icons.perm_identity_sharp),
            ),
          ],
        ));
  }
}