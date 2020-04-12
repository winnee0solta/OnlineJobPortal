import 'package:flutter/material.dart';

class UnverifiedAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Online Job Portal'),),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Text('Account needs to be verified !'),
      ),
    );
  }
}
