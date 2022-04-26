class ApiHelper {
  static final String domain = "http://192.168.1.65:8000";
  static final String baseurl = domain + "/api";
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
  static final String jsProfileData = baseurl + "/jobseeker-profile-data";
  static final String jsProfileDataUpdate =
      baseurl + "/jobseeker-profile-data/update";
  static final String jsUploadCv = baseurl + "/jobseeker-upload-cv";
  static final String jsDownloadCv = domain + "/images/jobseeker/cv/";
  static final String jsApplyForJob = baseurl + "/jobseeker/apply-for-job";
  static final String jsCheckIfAppliedForJob =
      baseurl + "/jobseeker/job/check-if-already-applied";
  //EM
  static final String emaccountverification =
      baseurl + "/employer-verification";
  static final String emProfileData = baseurl + "/employer-profile-data";

  static final String emUpdateProfileData =
      baseurl + "/employer-profile-data-update";
  static final String emJobPosts = baseurl + "/employer-job-posts";
  static final String addJobPost = baseurl + "/employer-add-job-post";
  static final String updateJobPost = baseurl + "/employer-update-job-post";
  static final String removeJobPost = baseurl + "/employer-remove-job-post";
  static final String emAppliedJobseekers =
      baseurl + "/employer/job/applied-jobseekers";

  static final String trash = baseurl + "/";
}
