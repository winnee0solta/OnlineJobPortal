class ApiHelper {
  static final String baseurl = "http://192.168.56.1:3000/api";
  static final String registerJobseeker = baseurl + "/register-jobseeker";
  static final String registerEmployeer = baseurl + "/register-employeer";
  static final String loginurl = baseurl + "/login";
  static final String resetpassword = baseurl + "/reset-password";
  static final String checktoken = baseurl + "/check-token";
  static final String updatepassword = baseurl + "/update-password";

static final String jobPosts = baseurl + "/job-posts";

  //JS
  static final String jsaccountverification =
      baseurl + "/jobseeker-verification";
  //EM
  static final String emaccountverification =
      baseurl + "/employer-verification";
  static final String emProfileData = baseurl + "/employer-profile-data";
  static final String emUpdateProfileData = baseurl + "/employer-profile-data-update";
  static final String addJobPost = baseurl + "/employer-add-job-post";
  static final String updateJobPost = baseurl + "/employer-update-job-post";
  static final String removeJobPost = baseurl + "/employer-remove-job-post";
  

  static final String trash = baseurl + "/";
}
