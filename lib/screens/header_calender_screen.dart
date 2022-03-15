import 'package:badges/badges.dart';
import 'package:cothinker/constants.dart';
import 'package:cothinker/screens/calender_screen.dart';
import 'package:cothinker/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../provider/calender_provider.dart';

class HeaderCalenderScreen extends StatelessWidget {
  const HeaderCalenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getListLength(BuildContext context) {
      final provider = Provider.of<CalenderProvider>(context);
      final calenderItemsFromProvider = provider.calender;
      return calenderItemsFromProvider.length.toString();
    }

    return Padding(
        padding: EdgeInsets.symmetric(vertical: kPadding, horizontal: kPadding),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const DueTitle(name: "Dein Medikamentenkalender"),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding / 3)),
                Center(
                  child: Badge(
                    badgeContent: Text(
                      getListLength(context),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: HexColor("0da6c5")),
                    ),
                    badgeColor: HexColor("#beebf4"),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
