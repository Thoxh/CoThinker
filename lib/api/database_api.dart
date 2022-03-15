import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cothinker/models/pill.dart';
import 'package:cothinker/utils/utils.dart';

import '../models/calender_insert.dart';

class DatabaseApi {
  static Stream<List<Pill>> readPills() => FirebaseFirestore.instance
      .collection("Pills")
      .snapshots()
      .transform(Utils.transformer(Pill.fromJson));

  static Stream<List<Calender>> readCalender() => FirebaseFirestore.instance
      .collection("Calender")
      .snapshots()
      .transform(Utils.transformer(Calender.fromJson));

  static Future<String> addPillToCalender(Calender calender) async {
    final docOrder = FirebaseFirestore.instance.collection("Calender").doc();
    calender.id = docOrder.id;
    await docOrder.set(calender.toJson()).then((result) {
      print("Upload was sucessful.");
    });
    return docOrder.id;
  }

  static Future deleteCalenderInsert(Calender calenderInsert) async {
    final docOrder = FirebaseFirestore.instance
        .collection("Calender")
        .doc(calenderInsert.id);
    await docOrder.delete();
  }

  static Future updateOrder(Calender calenderInsert) async {
    final docOrder = FirebaseFirestore.instance
        .collection("Calender")
        .doc(calenderInsert.id);
    await docOrder.update(calenderInsert.toJson());
  }
}
