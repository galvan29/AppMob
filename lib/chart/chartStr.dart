import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartRegistri {
  late final DateTime giorno;
  late final int durata;
  late final String voto;

  ChartRegistri({
    required this.giorno,
    required this.durata,
    required this.voto
  });
}