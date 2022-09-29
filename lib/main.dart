import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytraining/screen/base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(const MyTraining());
}

class MyTraining extends StatelessWidget {
  const MyTraining({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        colorScheme: ColorScheme.light(primary: const Color(0xff2a2a2a)),
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
    ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        /* appBar: AppBar(
          //title: const Text("myTraining"),   BARRA SOPRA METTERE QUI
        ), */
        body: Base(),
      ),
    );
  }
}
