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
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        /* appBar: AppBar(
          //title: const Text("Notebook"),   BARRA SOPRA METTERE QUI
        ), */
        body: Base(),
      ),
    );
  }
}
