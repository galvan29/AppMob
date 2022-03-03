import 'package:flutter/material.dart';
import 'package:mytraining/db/utentiDBworker.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/creaEvento.dart';
import 'package:mytraining/screen/firstPage.dart';
import 'package:mytraining/screen/homepage.dart';
import 'package:mytraining/screen/login.dart';
import 'package:mytraining/screen/mainSchede.dart';
import 'package:mytraining/screen/profilo.dart';
import 'package:mytraining/screen/register.dart';
import 'package:provider/provider.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class Base extends StatelessWidget {
  Base({Key? key}) : super(key: key) {
   // utentiModel.loadData(UtentiDBworker.utentiDBworker);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: utentiModel,
        child: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: Consumer<UtentiModel>(
            builder: (context, utentiModel, child) {
              return IndexedStack(
                index: utentiModel.stackIndex,
                children: [
                  FirstPage(),
                  LoginPage(),
                  RegisterPage(),
                  HomePage(),
                  MainSchede(),
                  Profilo(),
                  CreaEvento()
                ],
              );
            },
          ),
        ));
  }
}
