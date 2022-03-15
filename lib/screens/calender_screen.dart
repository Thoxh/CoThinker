import 'package:cothinker/constants.dart';
import 'package:flutter/material.dart';
import '../api/database_api.dart';
import '../provider/calender_provider.dart';
import 'package:cothinker/models/calender_insert.dart';
import 'package:provider/provider.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(kPadding),
        child: StreamBuilder<List<Calender>>(
            stream: DatabaseApi.readCalender(),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (snapshot.hasError) {
                    return const Text("Irgendetwas ist schief gelaufen.");
                  } else {
                    if (snapshot.hasData) {
                      final calenderItems = snapshot.data;
                      final provider = Provider.of<CalenderProvider>(context);
                      provider.setCalenderInserts(calenderItems!);
                      return const CalenderList();
                    } else {
                      return const Text("Überprüfe die Verbindung");
                    }
                  }
              }
            })));
  }
}

class CalenderList extends StatelessWidget {
  const CalenderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalenderProvider>(context);
    final calenderItemsFromProvider = provider.calender;
    return calenderItemsFromProvider.isEmpty
        ? const Center(
            child: Text("Keine Einträge vorhanden"),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final calenderItem = calenderItemsFromProvider[index];
              return CalenderInsert(calender: calenderItem);
            },
            itemCount: calenderItemsFromProvider.length);
  }
}
