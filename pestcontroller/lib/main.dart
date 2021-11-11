//@dart=2.9
import 'package:flutter/material.dart';
import 'package:pestcontroller/Welcome/welcome.dart';
import 'package:pestcontroller/imageresize.dart';
import 'package:pestcontroller/tfpratice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart' as p;
import 'package:charts_flutter/flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _future = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tensorflow Lite',
      theme: ThemeData(
        primaryIconTheme: IconThemeData(color: Colors.green),
        primaryColor: Colors.green,
        fontFamily: 'STIXTwotext',
      ),
      home: Welcome(),
    );
  }
}
