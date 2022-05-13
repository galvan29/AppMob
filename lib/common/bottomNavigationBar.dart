import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/login.dart';
import 'package:mytraining/screen/profilo2.dart';

Widget buildBottomNavigationBar(BuildContext context, var _currentIndex2) {
  int currentColor = _currentIndex2;
  return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.white, width: 0.1))),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentColor,
        backgroundColor: const Color.fromARGB(255, 42, 42, 42),
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 102, 99, 99),
        selectedFontSize: MediaQuery.of(context).size.height * 0.01,
        unselectedFontSize: MediaQuery.of(context).size.height * 0.01,
        onTap: (value) {
          if (value == 1) {
            utentiModel.setStackIndex(4);
            currentColor = 1;
          } else if (value == 2) {
            Profilo2.caricatoInfoProfilo = false;
            LoginPage().getValueLogin().then((val) async {
              utentiModel.utenteBeingEdited =
                  await UtentiDBworker.utentiDBworker.get(val);
            });
            Profilo2.caricatoInfoProfilo = true;
            utentiModel.setStackIndex(5);
            currentColor = 2;
            print("ciao");
            print(utentiModel.stackIndex);
          } else if (value == 0) {
            utentiModel.setStackIndex(3);
            currentColor = 0;
          }
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home, size: 25),
          ),
          BottomNavigationBarItem(
            label: 'Schede',
            icon: Icon(Icons.article_outlined, size: 25),
          ),
          BottomNavigationBarItem(
            label: 'Profilo',
            icon: Icon(Icons.perm_identity_sharp, size: 25),
          ),
        ],
      ));
}
