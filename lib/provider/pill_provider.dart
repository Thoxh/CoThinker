import 'package:cothinker/api/database_api.dart';
import 'package:cothinker/models/calender_insert.dart';
import 'package:cothinker/models/pill.dart';
import 'package:flutter/cupertino.dart';

class PillProvider extends ChangeNotifier {
  List<Pill> _pills = [];

  List<Pill> get pills => _pills.toList();

  void setOrders(List<Pill> orders) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _pills = orders;
      notifyListeners();
    });
  }
}
