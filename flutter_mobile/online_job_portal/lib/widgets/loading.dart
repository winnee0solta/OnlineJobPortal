import 'package:flutter/material.dart';

class LoadingLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CircularProgressIndicator(),),
    );
  }
}