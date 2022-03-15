import 'package:cothinker/models/calender_insert.dart';
import 'package:flutter/cupertino.dart';

import '../api/database_api.dart';

class CalenderProvider extends ChangeNotifier {
  List<Calender> _calender = [];

  List<Calender> get calender =>
      _calender.where((calender) => calender.isDone == false).toList();

  void setCalenderInserts(List<Calender> orders) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _calender = orders;
      notifyListeners();
    });
  }

  void addCalenderInsert(Calender calender) {
    DatabaseApi.addPillToCalender(calender);
  }

  void removeCalenderInsert(Calender? calenderInsert) {
    DatabaseApi.deleteCalenderInsert(calenderInsert!);
  }

  bool toggleCalenderisDone(Calender? calenderInsert) {
    calenderInsert!.isDone = !calenderInsert.isDone;
    DatabaseApi.updateOrder(calenderInsert);
    //notfiyListeners();
    return calenderInsert.isDone;
  }
}
