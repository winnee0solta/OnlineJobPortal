import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//screens
import 'package:online_job_portal/splash_screen.dart';

class JHomeScreen extends StatefulWidget {
  @override
  _JHomeScreenState createState() => _JHomeScreenState();
}

class _JHomeScreenState extends State<JHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Job Portal'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.face,
                color: Colors.white,
              ),
              onPressed: () {
                _viewProfile(context);
              }),
          IconButton(
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.white,
              ),
              onPressed: () {
                _logout(context);
              }),
        ], 
      ),
      body: Container(
        child: Text('JHome'),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }

  void _viewProfile(BuildContext context) {}
}
