import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:online_job_portal/helpers/api_helper.dart';
//screens
import 'em_profile_edit.dart';
import '../widgets/loading.dart';

class EmProfile extends StatefulWidget {
  @override
  _EmProfileState createState() => _EmProfileState();
}

class _EmProfileState extends State<EmProfile> {
  //variables
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Color fieldColor = Color(0xffedeef3);
  List profiledata = [];
  bool isloading = false;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Company Profile'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmProfileEdit()),
                );
              }),
        ],
      ),
      body: isloading
          ? LoadingLayout()
          : profiledata.length == 0
              ? Text('OOPS!')
              : SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        //company Email
                        ListTile(
                          title: Text('Company Email'),
                          subtitle: profiledata[0]["email"] != null
                              ? Text(profiledata[0]["email"])
                              : Text('-'),
                        ),

                        //company name
                        ListTile(
                          title: Text('Company Name'),
                          subtitle: profiledata[0]["company_name"] != null
                              ? Text(profiledata[0]["company_name"])
                              : Text('-'),
                        ),
                        //company Phone
                        ListTile(
                          title: Text('Company Phone'),
                          subtitle: profiledata[0]["company_phone"] != null
                              ? Text(profiledata[0]["company_phone"])
                              : Text('-'),
                        ),

                        //company Address
                        ListTile(
                          title: Text('Company Address'),
                          subtitle: profiledata[0]["company_address"] != null
                              ? Text(profiledata[0]["company_address"])
                              : Text('-'),
                        ),
                        //company Map
                        ListTile(
                          title: Text('Company Map Data'),
                          subtitle: profiledata[0]["email"] != null
                              ? Text(
                                  'lat : ${profiledata[0]["lat"]} , long : ${profiledata[0]["long"]}')
                              : Text('-'),
                        ),

                        //About Company
                        ListTile(
                            title: Text('About Company'),
                            subtitle: profiledata[0]["company_desc"] != null
                                ? Text(
                                    profiledata[0]["company_desc"],
                                    textAlign: TextAlign.justify,
                                  )
                                : Text('-')),
                      ],
                    ),
                  ),
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
    var response = await http.post(Uri.parse(url), body: {
      'user_id': userid.toString(), //need to send as string
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
          profiledata.add(data['datas']);
        });
      }
    }
  }
}
