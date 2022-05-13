import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/utentiModel.dart';

PreferredSize buildAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize:
    Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.zero,
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.07,
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
                  top: MediaQuery.of(context).size.height * 0.04,  //mytraining
                ),
                child: Text(
                    'MyTraining',
                    style: GoogleFonts.adventPro(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize:
                        MediaQuery.of(context).size.height * 0.02,
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
                  left: MediaQuery.of(context).size.width * 0.01,
                  top: MediaQuery.of(context).size.width * 0.07,
                ),
                child: IconButton(
                  icon: const Icon(Icons.info ),
                  onPressed: () {
                    utentiModel.setStackIndex(9);
                  },
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

      ],
    ),
  );
}