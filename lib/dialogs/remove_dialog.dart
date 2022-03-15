import 'package:cothinker/models/calender_insert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/calender_provider.dart';

class RemoveDialog extends StatelessWidget {
  final Calender calenderInsert;
  const RemoveDialog({Key? key, required this.calenderInsert})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("Abbrechen"));
    Widget continueButton = TextButton(
        onPressed: () {
          final provider =
              Provider.of<CalenderProvider>(context, listen: false);
          provider.removeCalenderInsert(calenderInsert);
          Navigator.of(context).pop();
        },
        child: const Text("Löschen"));
    return AlertDialog(
      title: const Text(
        "Termin entfernen?",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      content: const Text(
          "Dieser Termin wird aus der App und der Datenbank gelöscht. \nDieser Vorgang kann nicht rückgängig gemacht werden."),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  }
}
