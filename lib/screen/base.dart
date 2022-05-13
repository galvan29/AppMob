import 'package:flutter/material.dart';
import 'package:mytraining/models/utentiModel.dart';
import 'package:mytraining/screen/creaEvento.dart';
import 'package:mytraining/screen/firstPage2.dart';
import 'package:mytraining/screen/homepage.dart';
import 'package:mytraining/screen/login.dart';
import 'package:mytraining/screen/mainSchede.dart';
import 'package:mytraining/screen/profilo2.dart';
import 'package:mytraining/screen/register.dart';
import 'package:mytraining/widget/Widget.dart';
import 'package:provider/provider.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:mytraining/screen/istruzioni.dart';
import 'package:mytraining/screen/info.dart';
import 'package:flutter/services.dart';

class Base extends StatelessWidget {
  Base({Key? key}) : super(key: key);
  static int pageIndexForWidget = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider.value(
        value: utentiModel,
        child: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tocca ancora per uscire dalla applicazione',),
          ),
          child: Consumer<UtentiModel>(
            builder: (context, utentiModel, child) {
              return IndexedStack(
                index: utentiModel.stackIndex,
                children: [
                  const FirstPage2(),
                  LoginPage(),
                  RegisterPage(),
                  HomePage(),
                  MainSchede(),
                  Profilo2(),
                  CreaEvento(),
                  WidgetClass(),
                  Instruzioni(),
                  Info()
                ],
              );
            },
          ),
        ));
  }
}
