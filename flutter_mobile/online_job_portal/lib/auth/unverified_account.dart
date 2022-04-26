import 'package:flutter/material.dart';
import 'package:online_job_portal/splash_screen.dart';

class UnverifiedAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Job Portal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: <Widget>[
            Text('Account needs to be verified !'),
            SizedBox(
              height: 20.0,
            ),
            //button
            MaterialButton(
              minWidth: double.infinity,
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                );
              },
              color: Theme.of(context).accentColor,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'I have verified my mail.',
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
    );
  }
}
