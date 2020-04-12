import 'package:flutter/material.dart';
import 'package:online_job_portal/employeer/em_edit_jobpost.dart';
import 'package:online_job_portal/employeer/em_home.dart';
import 'package:online_job_portal/model/jobpost.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:online_job_portal/helpers/api_helper.dart';
//screens
import '../widgets/loading.dart';

class EmSingleJobPost extends StatefulWidget {
  final JobPost jobpost;

  EmSingleJobPost({Key key, @required this.jobpost}) : super(key: key);

  @override
  _EmSingleJobPostState createState() => _EmSingleJobPostState();
}

class _EmSingleJobPostState extends State<EmSingleJobPost> {
  //variables
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Color fieldColor = Color(0xffedeef3);
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Job Post'),
        actions: <Widget>[
          IconButton(
              tooltip: 'Edit',
              icon: Icon(
                Icons.chat_bubble,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmEditJopPost(
                            jobpost: widget.jobpost,
                          )),
                );
              }),
          IconButton(
              tooltip: 'Edit',
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmEditJopPost(
                            jobpost: widget.jobpost,
                          )),
                );
              }),
          IconButton(
              tooltip: 'Delete',
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                _removeDialog(context);
              }),
        ],
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

                    //TODO:fetch joobseekers
                    //TODO:future builder maybe or list<Widget>
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _removeDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Job Post ?'),
          content: const Text('This Post will no longer be available.'),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.black,
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              textColor: Colors.red,
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                _removePost();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _removePost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    setState(() {
      isloading = true;
    });

    var url = ApiHelper.removeJobPost;
    var response = await http.post(url, body: {
      'user_id': userid.toString(), //need to send as string
      'post_id': widget.jobpost.postid.toString(),
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

        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EHomeScreen()),
        );
      }
    } else {
      print('Response body: ${response.body}');
    }
    setState(() {
      isloading = false;
    });
  }
}
