import 'package:flutter/material.dart';

import 'schede.dart';
import 'schedeStruct.dart';
import 'training.dart';

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [
    modifica
  ];
  static const List<MenuItem> secondItems = [
    elimina
  ];

  static const modifica = MenuItem(text: 'Modifica', icon: Icons.construction);
  static const elimina = MenuItem(text: 'Elimina', icon: Icons.remove);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.modifica:
        Navigator.push<void>(
          context,
          MaterialPageRoute(
            builder: (context) => Training(),
          ),
        );
        break;
      case MenuItems.elimina:
        SchedeStruct a = new SchedeStruct(1, "fff", 120);
        PageSchedePage().rimuovi(a);
        Navigator.push<void>(
          context,
          MaterialPageRoute(
            builder: (context) => PageSchedePage(),
          ),
        );
        break;
    }
  }
}