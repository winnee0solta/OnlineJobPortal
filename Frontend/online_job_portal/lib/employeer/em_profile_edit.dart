import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:online_job_portal/helpers/api_helper.dart';
//screens
import '../widgets/loading.dart';

import 'em_profile.dart';

class EmProfileEdit extends StatefulWidget {
  @override
  _EmProfileEditState createState() => _EmProfileEditState();
}

class _EmProfileEditState extends State<EmProfileEdit> {
  bool isloading = false;
  List profiledata = [];

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final descController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    descController.dispose();
    latController.dispose();
    longController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isloading
          ? LoadingLayout()
          : ListView(
              children: <Widget>[
                //
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffedeef3),
                          hintText: 'Company Name',
                          labelText: 'Company Name',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffedeef3),
                          hintText: 'Company Address',
                          labelText: 'Company Address',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffedeef3),
                          hintText: 'Company Phone',
                          labelText: 'Company Phone',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        controller: descController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffedeef3),
                          hintText: 'About Company',
                          labelText: 'About Company',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        controller: latController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffedeef3),
                          hintText: 'Map Lat',
                          labelText: 'Map Lat',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        controller: longController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffedeef3),
                          hintText: 'Map Long',
                          labelText: 'Map Long',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                        ),
                      ),
                    ),
                  ),
                ),

                //button
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      if (!isloading) _updateProfile();
                    },
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        !isloading ? 'Update' : 'Please Wait..',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  @override
  void initState() {
    _fetchProfileData();
    super.initState();
  }

  Future<void> _fetchProfileData() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.emProfileData;
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
        nameController.text = data['datas']['company_name'];
        addressController.text = data['datas']['company_address'];
        phoneController.text = data['datas']['company_phone'];
        descController.text = data['datas']['company_desc'];
        latController.text = data['datas']['lat'];
        longController.text = data['datas']['long'];

        setState(() {
          isloading = false;
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');
    var name = nameController.text;
    var address = addressController.text;
    var phone = phoneController.text;
    var desc = descController.text;
    var lat = latController.text;
    var long = longController.text;

    var url = ApiHelper.emUpdateProfileData;
    var response = await http.post(url, body: {
      'user_id': userid.toString(), //need to send as string
      'name': name.toString(),
      'address': address.toString(),
      'phone': phone.toString(),
      'desc': desc.toString(),
      'lat': lat.toString(),
      'long': long.toString(),
    }, headers: {
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var data = json.decode(response.body);
      print('Response body: $data');
      if (data['status'] == 200) {
        setState(() {
          isloading = false;
        });

        //pop and go back home
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmProfile()),
        );
      }
    }
  }
}
