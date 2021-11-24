import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oasis/screens/splash/splash_screen.dart';
import 'package:oasis/app/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeLocator();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Access School Information System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashView(),
    );
  }
}
