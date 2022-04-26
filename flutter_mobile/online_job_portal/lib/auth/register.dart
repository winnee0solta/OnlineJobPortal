import 'package:flutter/material.dart';
import 'package:online_job_portal/helpers/api_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
//screens
import 'package:online_job_portal/splash_screen.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //variable
  bool jobseeker = true;
  bool registering = false;

  final Color fieldColor = Color(0xffedeef3);
  final Color brandColor = Color(0xffb0a999);
  //jobseeker
  final jEmailController = TextEditingController();
  final jPasswordController = TextEditingController();
  final jFullnameController = TextEditingController();
  final jPhonenoController = TextEditingController();
  final jAddressController = TextEditingController();
  //employer
  final eEmailController = TextEditingController();
  final ePasswordController = TextEditingController();
  final eCompanyNameController = TextEditingController();
  final eCompanyPhonenoController = TextEditingController();
  final eCompanyAddressController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    //jobseeker
    jEmailController.dispose();
    jPasswordController.dispose();
    jFullnameController.dispose();
    jPhonenoController.dispose();
    jAddressController.dispose();
    //employer
    eEmailController.dispose();
    ePasswordController.dispose();
    eCompanyNameController.dispose();
    eCompanyPhonenoController.dispose();
    eCompanyAddressController.dispose();
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
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 150.0,
                    onPressed: () {
                      _switchForm('j');
                    },
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Jobseeker',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    minWidth: 150.0,
                    onPressed: () {
                      _switchForm('e');
                    },
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Employeer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              jobseeker
                  ? _buildJobseekerForm(context)
                  : _buildEmployeerForm(context),
              SizedBox(
                height: 40.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  "Already have account ? Login",
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

  void _switchForm(String current) {
    //registering state
    if (registering) return;

    if (current == 'j' && !jobseeker) {
      jobseeker = true;
      setState(() {});
    }
    if (current == 'e' && jobseeker) {
      jobseeker = false;
      setState(() {});
    }
  }

  Widget _buildJobseekerForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: <Widget>[
          //fullname
          TextField(
            controller: jFullnameController,
            decoration: InputDecoration(
              filled: true,
              fillColor: fieldColor,
              hintText: 'Fullname',
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
          //phoneo
          TextField(
            controller: jPhonenoController,
            decoration: InputDecoration(
              filled: true,
              fillColor: fieldColor,
              hintText: 'Phone Number',
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
          //address
          TextField(
            controller: jAddressController,
            decoration: InputDecoration(
              filled: true,
              fillColor: fieldColor,
              hintText: 'Address',
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

          //email
          TextField(
            controller: jEmailController,
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
            controller: jPasswordController,
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
              if (!registering) {
                _registerJobseeker(context);
              }
            },
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                !registering
                    ? 'Register as Jobseeker'
                    : 'Please wait..Registering...',
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

  Widget _buildEmployeerForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: <Widget>[
          //company_name
          TextField(
            controller: eCompanyNameController,
            decoration: InputDecoration(
              filled: true,
              fillColor: fieldColor,
              hintText: 'Company Name',
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

          //company phone no
          TextField(
            controller: eCompanyPhonenoController,
            decoration: InputDecoration(
              filled: true,
              fillColor: fieldColor,
              hintText: 'Company Phone Number',
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
          //company address
          TextField(
            controller: eCompanyAddressController,
            decoration: InputDecoration(
              filled: true,
              fillColor: fieldColor,
              hintText: 'Company Address',
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

          //email
          TextField(
            controller: eEmailController,
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
            controller: ePasswordController,
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
              if (!registering) _registerEmployeer(context);
            },
            color: Theme.of(context).accentColor,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                !registering
                    ? 'Register as Employeer'
                    : 'Please wait..Registering...',
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

  Future<void> _registerJobseeker(BuildContext context) async {
    var fullname = jFullnameController.text;
    var phone = jPhonenoController.text;
    var address = jAddressController.text;
    var email = jEmailController.text;
    var password = jPasswordController.text;
    if (fullname != '' &&
        phone != '' &&
        address != '' &&
        email != '' &&
        password != '') {
      //registering state
      setState(() {
        registering = true;
      });
      var url = ApiHelper.registerJobseeker;
      var response = await http.post(Uri.parse(url), body: {
        'email': email,
        'password': password,
        'fullname': fullname,
        'phone_no': phone,
        'address': address,
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
          const snackBar = SnackBar(
            content: Text("Some error occured"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } else {
      //show snackbar
      const snackBar = SnackBar(
        content: Text("Empty Fields!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _registerEmployeer(BuildContext context) async {
    var companyname = eCompanyNameController.text;
    var companyphone = eCompanyPhonenoController.text;
    var companyaddress = eCompanyAddressController.text;
    var email = eEmailController.text;
    var password = ePasswordController.text;
    if (companyname != '' &&
        companyphone != '' &&
        companyaddress != '' &&
        email != '' &&
        password != '') {
      //registering state
      setState(() {
        registering = true;
      });
      var url = ApiHelper.registerEmployeer;
      var response = await http.post(Uri.parse(url), body: {
        'email': email,
        'password': password,
        'company_name': companyname,
        'company_phone': companyphone,
        'company_address': companyaddress,
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
          const snackBar = SnackBar(
            content: Text("Some error occured"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            registering = false;
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
        registering = false;
      });
    }

    setState(() {
      registering = false;
    });
  }
}
