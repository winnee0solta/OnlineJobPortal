class JobPost {
  String postid;
  String companyname;
  String companyaddress;
  String companyphone;
  String jobtitle;
  String jobtype;
  String designation;
  String qualification;
  String specialization;
  String skills;
  String lastdate;
  String desc;

  JobPost(
      {required this.postid,
      required this.companyname,
     required  this.companyaddress,
      required this.companyphone,
      required this.jobtitle,
     required  this.jobtype,
      required this.designation,
     required  this.qualification,
     required  this.specialization,
     required  this.skills,
     required  this.lastdate,
      required this.desc});

  factory JobPost.fromJson(Map<String, dynamic> json) {
    return JobPost(
      postid: json['post_id'].toString(),
      companyname: json['company_name'].toString(),
      companyaddress: json['company_address'].toString(),
      companyphone: json['company_phone'].toString(),
      jobtitle: json['jobtitle'].toString(),
      jobtype: json['jobtype'].toString(),
      designation: json['designation'].toString(),
      qualification: json['qualification'].toString(),
      specialization: json['specialization'].toString(),
      skills: json['skills'].toString(),
      lastdate: json['lastdate'].toString(),
      desc: json['desc'].toString(),
    );
  }
}
