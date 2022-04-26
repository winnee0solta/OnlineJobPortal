import 'package:flutter/material.dart';
import 'package:online_job_portal/model/jobpost.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:online_job_portal/helpers/api_helper.dart';
//screens
import '../widgets/loading.dart';
//screens
import 'package:online_job_portal/splash_screen.dart';
import 'em_profile.dart';
import 'em_addJobpost.dart';
import 'em_singlejoppost.dart';

class EHomeScreen extends StatefulWidget {
  @override
  _EHomeScreenState createState() => _EHomeScreenState();
}

class _EHomeScreenState extends State<EHomeScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  bool isloading = false;
  List<JobPost> jobposts = <JobPost>[];
  // Future
  //  Future<List<JobPost>>   jobposts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Job Portal'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.face,
                color: Colors.white,
              ),
              onPressed: () {
                _viewProfile(context);
              }),
          IconButton(
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.white,
              ),
              onPressed: () {
                _logout(context);
              }),
        ],
      ),
      body: isloading
          ? LoadingLayout()
          : RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _refresh,
              child: jobposts.length == 0
                  ? Center(
                      child: Text(
                      'No Posts !',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ))
                  : Container(
                      color: Color(0xfff2f3f5),
                      child: ListView.builder(
                        itemCount: jobposts.length,
                        itemBuilder: _buildItemsForListView,
                      )),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmAddJobPost()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildItemsForListView(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmSingleJobPost(
                jobpost: jobposts[index],
              ),
            ),
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //job title
                Text(
                  jobposts[index].jobtitle,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xff0a0a0a),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                //company name
                Text(
                  jobposts[index].companyname,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xffababab),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: <Widget>[
                    Chip(
                      backgroundColor: Color(0xfff1f2f4),
                      avatar: Icon(
                        Icons.location_on,
                        color: Color(0xffababab),
                      ),
                      label: Text(
                        jobposts[index].companyaddress,
                        style: TextStyle(
                          color: Color(0xffababab),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Chip(
                      backgroundColor: Color(0xfff1f2f4),
                      label: Text(
                        jobposts[index].jobtype,
                        style: TextStyle(
                          color: Color(0xffababab),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Chip(
                      backgroundColor: Color(0xfff1f2f4),
                      label: Text(
                        jobposts[index].qualification,
                        style: TextStyle(
                          color: Color(0xffababab),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                //skils
                Text(
                  jobposts[index].skills,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xffababab),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }

  void _viewProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmProfile()),
    );
  }

  @override
  void initState() {
    // _fetchPosts();
    super.initState();
    _populateJobPosts();
  }

  void _populateJobPosts() {
    _fetchPosts().then((posts) {
      setState(() {
        jobposts = posts;
      });
    });
  }

  Future<List<JobPost>> _fetchPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.emJobPosts;
    var response = await http.post(Uri.parse(url), body: {
      'user_id': userid.toString(), //need to send as string
    }, headers: {
      'Accept': 'application/json'
    });
    print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var responseJson = json.decode(response.body);
      print(responseJson['datas']);
      final items =
          (responseJson["datas"] as List).map((i) => new JobPost.fromJson(i));
      return items.toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          "Request to $url failed with status ${response.statusCode}: ${response.body}");
    }
  }

  Future<Null> _refresh() {
    setState(() {
      jobposts.clear();
    });
    return _fetchPosts().then((posts) {
      setState(() {
        jobposts = posts;
      });
    });
  }
}
