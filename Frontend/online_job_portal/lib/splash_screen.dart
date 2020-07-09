import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:online_job_portal/helpers/api_helper.dart';
//screens
import 'employeer/em_home.dart';
import 'jobseeker/js_home.dart';
import 'auth/login.dart';
import 'auth/unverified_account.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(child: 
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Image(image: AssetImage('assets/images/img_2.png')),
        ),),
      ),
    );
  }

  @override
  void initState() {
    checkIfAuthenticated();
    super.initState();
  }

  void checkIfAuthenticated() async {
    Navigator.of(context).popUntil((route) => route.isFirst);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getInt('user_id'));
    if (prefs.getInt('user_id') != null && prefs.getString('type') != null) {
      if (prefs.getString('type') == "jobseeker") {
        _jsAccountVerification(context);
      } else if (prefs.getString('type') == "employeer") {
        _emAccountVerification(context); 
      } else {
        //force logout
        prefs.clear();
        //login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } else {
      //login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  Future<void> _jsAccountVerification(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.jsaccountverification;
    var response = await http.post(url, body: {
      'user_id': userid.toString(), //need to send as string
    }, headers: {
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var data = json.decode(response.body);
      print('Response body: $data');
      if (data['status'] == 200) {
        if (data['datas']['email_verified']) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => JHomeScreen()),
          );
        } else {
           Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UnverifiedAccount()),
          );
        }
      }else if(data['status'] == 401){
        prefs.clear();
        checkIfAuthenticated();
      }
    }
  }

  Future<void> _emAccountVerification(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.emaccountverification;
    var response = await http.post(url, body: {
      'user_id': userid.toString(), //need to send as string
    }, headers: {
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var data = json.decode(response.body);
      print('Response body: $data');
      if (data['status'] == 200) {
        if (data['datas']['email_verified'] &&
            data['datas']['employer_verified']) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EHomeScreen()),
          );
        } else {
           Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UnverifiedAccount()),
          );
        }
      }
    }
  }
}
