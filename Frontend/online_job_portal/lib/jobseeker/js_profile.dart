import 'package:flutter/material.dart';

class JsProfile extends StatefulWidget {
  @override
  _JsProfileState createState() => _JsProfileState();
}

class _JsProfileState extends State<JsProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
           height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
             mainAxisSize: MainAxisSize.max,
             children: <Widget>[
               
             ],
          ),
        ),
      ),
    );
  }
}