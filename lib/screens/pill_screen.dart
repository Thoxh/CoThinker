import 'package:cothinker/api/database_api.dart';
import 'package:cothinker/constants.dart';
import 'package:cothinker/provider/pill_provider.dart';
import 'package:cothinker/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pill.dart';

/**
 * Klasse der Pillenliste im oberen Bereich der App.
 * Folgend wird die Klasse als StatelessWidget aufgerufen.
 * Somit handelt es sich bei dieser Klasse um eine Darstellung durch verschiedene Widgets.
 */

class PillScreen extends StatelessWidget {
  const PillScreen({Key? key}) : super(key: key);

  @override
  /*
  * Widget build(BuildContext context)
  * zeigt den Beginn der sichtbaren Darstellung 
  */
  Widget build(BuildContext context) {
    return Padding(
        // Abstandswidget
        padding: const EdgeInsets.symmetric(
            horizontal: 16), // 16 Pixel Abstand auf beiden horizontalen Seiten
        child: Column(
          // Column ist eine vertikale Auflistung von Widgets
          crossAxisAlignment: CrossAxisAlignment
              .start, // Die Widgets sollen am Anfang der Krossaxe angeordnet sein
          children: [
            // children = alle widgets der vertikalen Auflistung
            DueTitle(
                name:
                    "Deine Medikamente"), // Verweis auf die selbsterstellte Klasse DueTitle mit dem Parameter name
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical:
                        8)), // Vertikaler Abstand auf beiden vertikalen Seiten
            Expanded(
              // Expanded = Widget nimmt so viel Platz wie möglich ein
              child: StreamBuilder<List<Pill>>(
                  // StreamBuilder = Streamt dauerhaft zur Datenbank um Änderungen direkt zu erkennen
                  stream: DatabaseApi
                      .readPills(), // Verweis auuf die Datenbank API und die Methode "readPills"
                  builder: ((context, snapshot) {
                    switch (snapshot.connectionState) {
                      /*
                      * Schaut auf folgende Fälle:
                      * 1. Wenn Verbindung austehend ist, zeige eine Prozessleiste
                      * 2. Wenn Daten aus der Datenbank Fehler enthalten, zeige "Irgendetwas ist schief gelaufen"
                      * 3. Wenn alles in Ordnung ist, zeige die Pillenliste mit ihren Daten aus der Providerklasse
                      */
                      case ConnectionState.waiting: // 1.
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (snapshot.hasError) {
                          return const Text(
                              "Irgendetwas ist schief gelaufen."); // 2.
                        } else {
                          if (snapshot.hasData) {
                            // 3.
                            final orders = snapshot
                                .data; // Variable orders entspricht den Daten aus der Datenbank
                            final provider = Provider.of<PillProvider>(
                                context); // Variable provider ist eine Referenz auf die Provider-Klasse PillProvider
                            provider.setOrders(
                                orders!); // Zugriff auf PillProvider und seiner Klasse setOrders, mit den Datenbank Daten als Parameter
                            return const PillList(); // Zeige die Pillenliste siehe unten
                          } else {
                            return const Text(
                                "Überprüfe die Verbindung"); // Wenn 1., 2., und 3. nicht stimmen, zeige "Überprüfe die Verbindung"
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
    final provider = Provider.of<PillProvider>(
        context); // Variable provider ist eine Referenz auf die Provider-Klasse PillProvider
    final pillsFromProvider = provider
        .pills; // Variable pillsFromProvider entspricht den Pillen, welche oben (setOrders) vom Provider aus der Datenbank geholten wurden
    return pillsFromProvider
            .isEmpty // Wenn keine Pillen im Provider sind, zeige "Keine Einträge vorhanden"
        ? const Center(
            child: Text("Keine Einträge vorhanden"),
          )
        : ListView.builder(
            // Ansonsten nutze das Widget "ListView"
            scrollDirection: Axis.horizontal, // horizontale Scroll-Richtung
            physics:
                const BouncingScrollPhysics(), // Bouncy Physik beim Scrollen
            itemBuilder: (context, index) {
              final pill = pillsFromProvider[
                  index]; // Variable pill entspricht jedem Datensatz der Pillen aus dem Provider und schlussendlich aus der Datenbank
              return PillModel(
                  pill:
                      pill); // Zeige die Klasse PillModel als Darstellung mit den Daten aus der Variable pill, welche als Parameter übergeben wird
            },
            itemCount: pillsFromProvider.length);
  }
}
