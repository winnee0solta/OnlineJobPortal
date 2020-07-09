import 'package:flutter/material.dart';
import 'package:online_job_portal/helpers/api_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
//screens
import 'package:online_job_portal/splash_screen.dart';
// screens
import 'register.dart';
import 'password_reset.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //variables
  bool logingin = false;
  final Color fieldColor = Color(0xffedeef3);
  final Color brandColor = Color(0xffb0a999);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 80.0,
              ),
              //brandname
              Text(
                'Online Job Portal',
                style: TextStyle(
                    fontSize: 20.0,
                    color: brandColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 100.0,
              ),
              //welcome back
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: <Widget>[
                    //email
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: fieldColor,
                        hintText: 'Email',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),

                    //password
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: fieldColor,
                        hintText: 'Password',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    SizedBox(
                      height: 45.0,
                    ),

                    //button
                    MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {
                        if (!logingin) _loginUser(context);
                      },
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          !logingin ? 'Login' : 'Please Wait..',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PasswordReset()),
                  );
                },
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
              ),

              SizedBox(
                height: 40.0,
              ),

              GestureDetector(
                onTap: () {
                  _registerScreen();
                },
                child: Text(
                  "Don\'t have account ? Sign Up",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  Future<void> _loginUser(BuildContext context) async {
    var email = emailController.text;
    var password = passwordController.text;
    if (email != '' && password != '') {
      //registering state
      setState(() {
        logingin = true;
      });
      var url = ApiHelper.loginurl;
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          //store value
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt('user_id', data['user']['id']);
          prefs.setString('type', data['user']['type']);

          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SplashScreen()),
          );
        } else {
          //show snackbar
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(data['message'])));
          setState(() {
            logingin = false;
          });
        }
      }
    } else {
      //show snackbar
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Empty Fields!')));
      setState(() {
        logingin = false;
      });
    }
  }
}
