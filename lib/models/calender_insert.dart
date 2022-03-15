import 'package:badges/badges.dart';
import 'package:cothinker/constants.dart';
import 'package:cothinker/dialogs/remove_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../provider/calender_provider.dart';

// Kalenderobjekt
class Calender {
  String name;
  String imageDirectory;
  String description;
  String time;
  String date;
  String id;
  int pieces;
  bool isDone;

  Calender({
    required this.name,
    required this.imageDirectory,
    required this.description,
    required this.time,
    required this.date,
    required this.id,
    required this.pieces,
    required this.isDone,
  });

  // Von lokalem Kalenderobjekt zum Datenbankobjekt (Format ändern, um auf der Datenbank hochzuladen)
  Map<String, dynamic> toJson() => {
        'name': name,
        'imageDirectory': imageDirectory,
        'description': description,
        'time': time,
        'date': date,
        'id': id,
        'isDone': isDone,
        'pieces': pieces,
      };

  // Von Datenbankobjekt zum lokalem Kalenderobjekt (Format der Datenbank wieder für das Programm benutzbar machen)
  static Calender fromJson(Map<String, dynamic> json) => Calender(
      name: json['name'],
      imageDirectory: json['imageDirectory'],
      description: json['description'],
      time: json['time'],
      date: json['date'],
      id: json['id'],
      isDone: json['isDone'],
      pieces: json['pieces']);
}

class CalenderInsert extends StatelessWidget {
  final Calender calender;
  const CalenderInsert({Key? key, required this.calender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: kPadding, vertical: kPadding / 2),
      child: InkWell(
        onLongPress: (() {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  RemoveDialog(calenderInsert: calender));
        }),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(calender.time),
                    FittedBox(
                      child: Text(
                        calender.date,
                        style: TextStyle(
                            color: HexColor("#151635"),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                )),
            Padding(padding: EdgeInsets.symmetric(horizontal: kPadding / 2)),
            Expanded(
              flex: 5,
              child: Container(
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: HexColor("#151635"),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/" + calender.imageDirectory + ".png",
                        width: 30,
                      ),
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: kPadding / 2)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(calender.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          Text(calender.description,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 10,
                              )),
                        ],
                      ),
                      const Spacer(),
                      Badge(
                        badgeContent: Text(
                          calender.pieces.toString(),
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        badgeColor: Colors.white,
                      ),
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: kPadding / 2)),
                      InkWell(
                        onTap: () {
                          final provider = Provider.of<CalenderProvider>(
                              context,
                              listen: false);
                          final isDone =
                              provider.toggleCalenderisDone(calender);
                        },
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
