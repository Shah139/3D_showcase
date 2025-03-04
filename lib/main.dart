import 'package:demo/screens/aero_viewer_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aero Model Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AeroViewerScreen(),
    );
  }
}