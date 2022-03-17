import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytraining/common/appbar.dart';
import 'package:mytraining/db/eventiDBworrker.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/eventiModel.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/login.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:mytraining/common/bottomNavigationBar.dart';


BottomNavigationBar buildBottomNavigationBar(BuildContext context, var _currentIndex) {

  return BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  currentIndex: _currentIndex,
  backgroundColor: const Color.fromARGB(255, 42, 42, 42),
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.black,
  selectedFontSize: MediaQuery.of(context).size.height * 0.01,
  unselectedFontSize: MediaQuery.of(context).size.height * 0.01,
  onTap: (value) {
  if (value == 1) {
  utentiModel.setStackIndex(4);
  } else if (value == 2) {
  LoginPage().getValueLogin().then((val) async {
  utentiModel.utenteBeingEdited =
  await UtentiDBworker.utentiDBworker.get(val);
  });
  utentiModel.setStackIndex(5);
  } else if (value == 0) {
    utentiModel.setStackIndex(3);
  }
  },
  items: const [
  BottomNavigationBarItem(
  label: '',
  icon: Icon(Icons.home, size: 35),
  ),
  BottomNavigationBarItem(
  label: '',
  icon: Icon(Icons.article_outlined, size: 35),
  ),
  BottomNavigationBarItem(
  label: '',
  icon: Icon(Icons.perm_identity_sharp, size: 35),
  ),
  ],

  );
}