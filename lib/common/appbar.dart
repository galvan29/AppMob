import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSize buildAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize:
    Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.zero,
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 42, 42, 42),
),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(),
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01,
                  top: MediaQuery.of(context).size.width * 0.08,
                ),
                child: Text('MyTraining',
                    style: GoogleFonts.adventPro(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize:
                        MediaQuery.of(context).size.height * 0.03,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 1),
              ),
              /*Container(
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(),
                  margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      schedeModel.setStackIndex(4);
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.02,
                        width: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border: Border.all(
                                color: Colors.black, width: 1)),
                        child:
                        const Text("Riprendi")
                    ),
                  ))*/
            ],
          ),
        ),
      ],
    ),
  );
}