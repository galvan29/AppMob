import 'package:flutter/material.dart';
import 'package:mytraining/db/schedeDBworker.dart';
import 'package:mytraining/models/schedeModel.dart';
import 'package:mytraining/screen/creaEsercizio.dart';
import 'package:mytraining/screen/creaScheda.dart';
import 'package:mytraining/screen/fineAllenamento.dart';
import 'package:mytraining/screen/schede.dart';
import 'package:mytraining/screen/visualizzaScheda.dart';
import 'package:provider/provider.dart';

class MainSchede extends StatelessWidget {
  MainSchede({Key? key}) : super(key: key) {
    schedeModel.loadData(SchedeDBworker.schedeDBworker);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: schedeModel,
      child: Consumer<SchedeModel>(
        builder: (context, schedeModel, child) {
          return IndexedStack(
            index: schedeModel.stackIndex,
            children: [
              Schede(),
              CreaScheda(),
              VisualizzaScheda(),
              CreaEsercizio(),
              FineAllenamento()
            ],
          );
        },
      ),
    );
  }
}
