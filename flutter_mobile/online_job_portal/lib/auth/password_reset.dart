import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:online_job_portal/helpers/api_helper.dart';

import 'package:online_job_portal/splash_screen.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  bool isloading = false;
  int _layoutVal = 1;
  final Color fieldColor = const Color(0xffedeef3);
  final Color brandColor = const Color(0xffb0a999);
  final emailController = TextEditingController();
  final tokenController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey =   GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    emailController.dispose();
    tokenController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: isloading
          ? _buildLoadingLayout()
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  _buildLayout(context),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildLoadingLayout() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildLayout(BuildContext context) {
    Widget rwidg;
    switch (_layoutVal) {
      case 1:
        rwidg = _buildFirstLayout(context);
        break;
      case 2:
        rwidg = _buildSecondLayout(context);
        break;
      case 3:
        rwidg = _buildThirdLayout(context);
        break;
      default:
        rwidg = Text('Restart App');
        break;
    }
    return rwidg;
  }

  Widget _buildFirstLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Enter your email',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 20.0,
          ),

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
            height: 45.0,
          ),

          //button
          MaterialButton(
            minWidth: double.infinity,
            onPressed: () {
              if (!isloading) _resetPassword(context);
            },
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Reset Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _resetPassword(BuildContext context) async {
    var email = emailController.text;
    if (email != '') {
      //registering state
      setState(() {
        isloading = true;
      });
      var url = ApiHelper.resetpassword;
      var response = await http.post(Uri.parse(url), body: {
        'email': email,
      });
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          //show snackbar
          const snackBar = SnackBar(
            content: Text("Token sent to email."),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          isloading = false;
          _layoutVal = 2;
          setState(() {});
        } else {
          //show snackbar
          const snackBar = SnackBar(
            content: Text("Some error occured"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            isloading = false;
          });
        }
      }
    } else {
      //show snackbar
      const snackBar = SnackBar(
        content: Text("Empty Fields!"),
      );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isloading = false;
      });
    }
  }

  Widget _buildSecondLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Enter token (sent to email)',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 20.0,
          ),

          //token
          TextField(
            controller: tokenController,
            decoration: InputDecoration(
              filled: true,
              fillColor: fieldColor,
              hintText: 'Token',
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
              if (!isloading) _checkToken(context);
            },
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _checkToken(BuildContext context) async {
    var token = tokenController.text;
    var email = emailController.text;
    if (token != '' && email != '') {
      //registering state
      setState(() {
        isloading = true;
      });
      var url = ApiHelper.checktoken;
      var response = await http.post(Uri.parse(url), body: {
        'email': email,
        'token': token.toString(),
      });
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          isloading = false;
          _layoutVal = 3;
          setState(() {});
        } else {
          //show snackbar
          const snackBar = SnackBar(
            content: Text("Some error occured"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          setState(() {
            isloading = false;
          });
        }
      }
    } else {
      //show snackbar
      const snackBar = SnackBar(
        content: Text("Empty Fields!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      setState(() {
        isloading = false;
      });
    }
  }

  Widget _buildThirdLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: <Widget>[
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
              if (!isloading) _changePassword(context);
            },
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Change Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _changePassword(BuildContext context) async {
    var email = emailController.text;
    var password = passwordController.text;
    if (email != '' && password != '') {
      //registering state
      setState(() {
        isloading = true;
      });
      var url = ApiHelper.updatepassword;
      var response = await http.post(Uri.parse(url), body: {
        'email': email,
        'password': password.toString(),
      }, headers: {
        'Accept': 'application/json'
      });
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          isloading = false;

          setState(() {});

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SplashScreen()),
          );
        } else {
          //show snackbar
          const snackBar = SnackBar(
            content: Text("Some error occured"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          setState(() {
            isloading = false;
          });
        }
      }
    } else {
      //show snackbar
      const snackBar = SnackBar(
        content: Text("Empty Fields!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      setState(() {
        isloading = false;
      });
    }
  }
}
