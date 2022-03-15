import 'package:cothinker/provider/calender_provider.dart';
import 'package:cothinker/provider/pill_provider.dart';
import 'package:cothinker/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PillProvider()),
      ChangeNotifierProvider(create: (context) => CalenderProvider()),
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Co-Thinker',
      theme: ThemeData(fontFamily: "EuclidCircularA"),
      home: const MainScreen(),
      color: Colors.white,
    );
  }
}
