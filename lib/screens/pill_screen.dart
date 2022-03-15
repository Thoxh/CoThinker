import 'package:cothinker/api/database_api.dart';
import 'package:cothinker/constants.dart';
import 'package:cothinker/provider/pill_provider.dart';
import 'package:cothinker/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pill.dart';

class PillScreen extends StatelessWidget {
  const PillScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DueTitle(name: "Deine Medikamente"),
            Padding(padding: EdgeInsets.symmetric(vertical: kPadding / 2)),
            Expanded(
              child: StreamBuilder<List<Pill>>(
                  stream: DatabaseApi.readPills(),
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
                            final orders = snapshot.data;
                            final provider = Provider.of<PillProvider>(context);
                            provider.setOrders(orders!);
                            return const PillList();
                          } else {
                            return const Text("Überprüfe die Verbindung");
                          }
                        }
                    }
                  })),
            ),
          ],
        ));
  }
}

class PillList extends StatelessWidget {
  const PillList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PillProvider>(context);
    final pillsFromProvider = provider.pills;
    return pillsFromProvider.isEmpty
        ? const Center(
            child: Text("Keine Einträge vorhanden"),
          )
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final pill = pillsFromProvider[index];
              return PillModel(pill: pill);
            },
            itemCount: pillsFromProvider.length);
  }
}
