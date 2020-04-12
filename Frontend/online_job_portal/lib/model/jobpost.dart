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
      {this.postid,
      this.companyname,
      this.companyaddress,
      this.companyphone,
      this.jobtitle,
      this.jobtype,
      this.designation,
      this.qualification,
      this.specialization,
      this.skills,
      this.lastdate,
      this.desc});

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
