import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_job_portal/employeer/em_edit_jobpost.dart';
import 'package:online_job_portal/employeer/em_home.dart';
import 'package:online_job_portal/jobseeker/js_profile.dart';
import 'package:online_job_portal/model/jobpost.dart';
import 'package:path_provider/path_provider.dart';
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
  List<TableRow> tablerows = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Job Post'),
        actions: <Widget>[
          // IconButton(
          //     tooltip: 'Edit',
          //     icon: Icon(
          //       Icons.chat_bubble,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => EmEditJopPost(
          //                   jobpost: widget.jobpost,
          //                 )),
          //       );
          //     }),
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
                    ListTile(
                      title: Text(
                        'Applied JobSeekers',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        border: TableBorder.all(),
                        children: tablerows,
                      ),
                    ),
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

  @override
  void initState() {
    super.initState();

    //initial table header
    tablerows.add(TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Fullname'),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Phone no'),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Address'),
      ),
      Padding(padding: const EdgeInsets.all(8.0), child: Text('CV')),
    ]));

    _fetchAppliedJobseekers();
  }

  //fetch applied jobseekers

  //check if already applied
  Future<void> _fetchAppliedJobseekers() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var response = await http.post(ApiHelper.emAppliedJobseekers, body: {
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
        // appliedForJob = data['datas']['applied'];

        List datas = data['datas'];
        datas.forEach((data) {
          tablerows.add(TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(data['fullname']),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(data['phone_no']),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(data['address']),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: data['cv'] == 'no'
                  ? Text('No CV')
                  : MaterialButton(
                      onPressed: () {
                        _viewCV(data['cv']);
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'View CV.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
            ),
          ]));
        });

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

  void _viewCV(var cv) async {
    createFileOfPdfUrl(cv).then((f) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PDFScreen(f.path)),
      );
    });
  }

  Future<File> createFileOfPdfUrl(var cv) async {
    final url = ApiHelper.jsDownloadCv + cv;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}
