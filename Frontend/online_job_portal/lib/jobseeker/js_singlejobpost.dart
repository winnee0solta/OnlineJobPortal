import 'package:flutter/material.dart';
import 'package:online_job_portal/model/jobpost.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:online_job_portal/helpers/api_helper.dart';
//screens
import '../widgets/loading.dart';

class JsSingleJobPost extends StatefulWidget {
  final JobPost jobpost;

  JsSingleJobPost({Key key, @required this.jobpost}) : super(key: key);

  @override
  _JsSingleJobPostState createState() => _JsSingleJobPostState();
}

class _JsSingleJobPostState extends State<JsSingleJobPost> {
  //variables
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isloading = false;
  bool appliedForJob = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.jobpost.jobtitle),
      ),
      body: isloading
          ? LoadingLayout()
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      title: Text('Job Title'),
                      subtitle: Text(widget.jobpost.jobtitle),
                    ),
                    ListTile(
                      title: Text('Job Type'),
                      subtitle: Text(widget.jobpost.jobtype),
                    ),
                    ListTile(
                      title: Text('Job Designation'),
                      subtitle: Text(widget.jobpost.designation),
                    ),
                    ListTile(
                      title: Text('Qualification'),
                      subtitle: Text(widget.jobpost.qualification),
                    ),
                    ListTile(
                      title: Text('Job Specialization'),
                      subtitle: Text(widget.jobpost.specialization),
                    ),
                    ListTile(
                      title: Text('Skills'),
                      subtitle: Text(widget.jobpost.skills),
                    ),
                    ListTile(
                      title: Text('Deadline'),
                      subtitle: Text(widget.jobpost.lastdate),
                    ),
                    ListTile(
                      title: Text('Job Description'),
                      subtitle: Text(widget.jobpost.desc),
                    ),

                    //apply
                    SizedBox(
                      height: 20.0,
                    ),
                    //button
                    MaterialButton(
                      onPressed: () {
                        if(!appliedForJob)
                        _applyForJob();
                      },
                      color: !appliedForJob? Theme.of(context).primaryColor : Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          !appliedForJob ? 'Apply for the job post' : 'Already Applied For Job.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'Valid CV must be uploaded through profile section in order to apply for the jobpost.',
                        style:
                            TextStyle(fontSize: 14.0, color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  //apply for job
  Future<void> _applyForJob() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var response = await http.post(ApiHelper.jsApplyForJob, body: {
      'user_id': userid.toString(), //need to send as string
      'job_id': widget.jobpost.postid.toString(),
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
        //pop
        Navigator.of(context).pop();
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch valid response');
    }

    setState(() {
      isloading = false;
    });
  }


@override
void initState() { 
  super.initState();
  _checkIfAlreadyApplied();
}
  //check if already applied
  Future<void> _checkIfAlreadyApplied() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var response = await http.post(ApiHelper.jsCheckIfAppliedForJob, body: {
      'user_id': userid.toString(), //need to send as string
      'job_id': widget.jobpost.postid.toString(),
    }, headers: {
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var data = json.decode(response.body);
      print('Response body: $data');
      if (data['status'] == 200) {

        appliedForJob = data['datas']['applied'];
        setState(() {
          isloading = false;
        });
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch valid response');
    }

    setState(() {
      isloading = false;
    });
  }


  
}
