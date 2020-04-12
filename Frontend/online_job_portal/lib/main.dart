import 'package:flutter/material.dart';
//screens
import 'splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: const Color(0xff002651),
        accentColor: const Color(0xffff304f),
      ),
      home: SplashScreen(),
    );
  }
}
