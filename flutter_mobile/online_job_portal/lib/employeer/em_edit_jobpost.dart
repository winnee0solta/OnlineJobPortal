import 'package:flutter/material.dart';
import 'package:online_job_portal/model/jobpost.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:online_job_portal/helpers/api_helper.dart';
import 'package:intl/intl.dart';
//screens
import '../widgets/loading.dart';
import 'em_home.dart';

class EmEditJopPost extends StatefulWidget {
  final JobPost jobpost;

  EmEditJopPost({Key? key, required this.jobpost}) : super(key: key);

  @override
  _EmEditJopPostState createState() => _EmEditJopPostState();
}

class _EmEditJopPostState extends State<EmEditJopPost> {
  //variables
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Color fieldColor = Color(0xffedeef3);
  bool isloading = false;
  final jobtitle = TextEditingController();
  final jobtype = TextEditingController();
  final designation = TextEditingController();
  final qualification = TextEditingController();
  final specialization = TextEditingController();
  final skills = TextEditingController();
  final lastdate = TextEditingController();
  final desc = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    jobtitle.dispose();
    jobtype.dispose();
    designation.dispose();
    qualification.dispose();
    specialization.dispose();
    skills.dispose();
    lastdate.dispose();
    desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Job Post'),
      ),
      body: isloading
          ? LoadingLayout()
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                      //Job Title
                      TextField(
                        controller: jobtitle,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fieldColor,
                          hintText: 'Job Title',
                          labelText: 'Job Title',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      //Job type
                      TextField(
                        controller: jobtype,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fieldColor,
                          hintText: 'Job Type',
                          labelText: 'Job Type',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      //designation
                      TextField(
                        controller: designation,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fieldColor,
                          hintText: 'Job Designation',
                          labelText: 'Job Designation',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      //Qualification
                      TextField(
                        controller: qualification,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fieldColor,
                          hintText: 'Qualification',
                          labelText: 'Qualification',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      //Specialization
                      TextField(
                        controller: specialization,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fieldColor,
                          hintText: 'Job Specialization',
                          labelText: 'Job Specialization',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      //Skills
                      TextField(
                        controller: skills,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fieldColor,
                          hintText: 'Skills',
                          labelText: 'Skills',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      //last date of application
                      GestureDetector(
                        onTap: () => _picDate(context),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: lastdate,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: fieldColor,
                              hintText: 'Deadline',
                              labelText: 'Deadline',
                              prefixIcon: Icon(
                                Icons.dialpad,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(0.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(0.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      //job desc
                      TextField(
                        controller: desc,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fieldColor,
                          hintText: 'Job Description',
                          labelText: 'Job Description',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(0.0)),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      //button
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          onPressed: () {
                            if (!isloading) _updateJobPost();
                          },
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              !isloading ? 'Update Post' : 'Please Wait..',
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
                ),
              ),
            ),
    );
  }

  Future<void> _updateJobPost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');
    var jobtitleVal = jobtitle.text;
    var jobtypeVal = jobtype.text;
    var designationVal = designation.text;
    var qualificationVal = qualification.text;
    var specializationVal = specialization.text;
    var skillsVal = skills.text;
    var lastdateVal = lastdate.text;
    var descVal = desc.text;

    if (jobtitleVal == '' ||
        jobtypeVal == '' ||
        designationVal == '' ||
        qualificationVal == '' ||
        specializationVal == '' ||
        skillsVal == '' ||
        lastdateVal == '' ||
        descVal == '') {
      //show snackbar
      const snackBar = SnackBar(
        content: Text("Empty Fields!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }

    setState(() {
      isloading = true;
    });
    print('here');

    var url = ApiHelper.updateJobPost;
    var response = await http.post(Uri.parse(url), body: {
      'user_id': userid.toString(), //need to send as string
      'post_id': widget.jobpost.postid.toString(),
      'jobtitle': jobtitleVal.toString(),
      'jobtype': jobtypeVal.toString(),
      'designation': designationVal.toString(),
      'qualification': qualificationVal.toString(),
      'specialization': specializationVal.toString(),
      'skills': skillsVal.toString(),
      'lastdate': lastdateVal.toString(),
      'desc': descVal.toString(),
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EHomeScreen()),
        );
      }
    } else {
      print('Response body: ${response.body}');
    }
  }

  _picDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        selectedDate = picked;
        lastdate.value = TextEditingValue(text: formattedDate);
      });
    }
  }

  @override
  void initState() {
    _populateControllers();
    super.initState();
  }

  void _populateControllers() {
    jobtitle.value = TextEditingValue(text: widget.jobpost.jobtitle);
    jobtype.value = TextEditingValue(text: widget.jobpost.jobtype);
    designation.value = TextEditingValue(text: widget.jobpost.designation);
    qualification.value = TextEditingValue(text: widget.jobpost.qualification);
    specialization.value =
        TextEditingValue(text: widget.jobpost.specialization);
    skills.value = TextEditingValue(text: widget.jobpost.skills);
    lastdate.value = TextEditingValue(text: widget.jobpost.lastdate);
    desc.value = TextEditingValue(text: widget.jobpost.desc);
    setState(() {});
  }
}
