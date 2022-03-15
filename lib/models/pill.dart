import 'package:cothinker/constants.dart';
import 'package:cothinker/models/calender_insert.dart';
import 'package:cothinker/provider/calender_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// Kalenderobjekt
class Pill {
  String name;
  String imageDirectory;
  String description;
  String id;
  int pieces;

  Pill(
      {required this.name,
      required this.imageDirectory,
      required this.description,
      required this.pieces,
      required this.id});

  // Von lokalem Pillenobjekt zum Datenbankobjekt (Format ändern, um auf der Datenbank hochzuladen)
  Map<String, dynamic> toJson() => {
        'name': name,
        'imageDirectory': imageDirectory,
        'description': description,
        'id': id,
        'pieces': pieces
      };

  // Von Datenbankobjekt zum lokalem Pillenobjekt (Format der Datenbank wieder für das Programm benutzbar machen)
  static Pill fromJson(Map<String, dynamic> json) => Pill(
      name: json['name'],
      imageDirectory: json['imageDirectory'],
      description: json['description'],
      id: json['id'],
      pieces: json['pieces']);
}

class PillModel extends StatelessWidget {
  final Pill pill;

  void addOrder(BuildContext context) {
    String date = "00.00.00";
    String time = "00:00";
    DatePicker.showDateTimePicker(context, locale: LocaleType.de,
        onChanged: (value) {
      date = DateFormat("dd.MM.yyyy").format(value);
      time = DateFormat("HH:mm").format(value);
    }, onConfirm: (value) {
      date = DateFormat("dd.MM.yyyy").format(value);
      time = DateFormat("HH:mm").format(value);
      final calender = Calender(
        name: pill.name,
        imageDirectory: pill.imageDirectory,
        description: pill.description,
        time: time,
        date: date,
        id: "",
        isDone: false,
        pieces: pill.pieces,
      );
      final provider = Provider.of<CalenderProvider>(context, listen: false);
      provider.addCalenderInsert(calender);
      print("Function works");
    });
  }

  const PillModel({Key? key, required this.pill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding / 4),
      child: Container(
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: HexColor("#151635")),
        child: InkWell(
          onTap: () {
            addOrder(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(kPadding / 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(pill.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kPadding / 3),
                  child: SizedBox(
                    width: 20,
                    height: 1,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
                Image.asset(
                  "assets/" + pill.imageDirectory + ".png",
                  width: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
