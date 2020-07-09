<?php

namespace App\Http\Controllers\Mobile;

use App\ApplyForJobs;
use App\EmployeerInfo;
use App\EmployerMapData;
use App\Http\Controllers\Controller;
use App\JobPosts;
use App\JobSeekerCv;
use App\JobseekerInfo;
use App\User;
use App\UserVerifiedData;
use App\VerifiedEmployers;
use Illuminate\Http\Request;

class EmployersController extends Controller
{
    public function  checkVerificationStatus(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
        ]);

        $user = User::find($request->user_id);
        if ($user) {

            if (VerifiedEmployers::where('user_id', $request->user_id)->count() > 0) {
                //verified
                $verified = true;
            } else {
                $verified = false;
            }


            if (UserVerifiedData::where('user_id', $request->user_id)->count() > 0) {
                //verified
                $everified = true;
            } else {
                $everified = false;
            }

            $response = array(
                'status' => 200,
                'message' => 'OK',
                'datas' => array(
                    'email_verified' => $everified,
                    'employer_verified' => $verified,
                )
            );
            return Response($response);
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
    public function  profileData(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
        ]);

        $user = User::find($request->user_id);
        if ($user) {

            $info =  EmployeerInfo::where('user_id', $request->user_id)->first();
            $lat = '-';
            $long = '-';
            if (EmployerMapData::where('user_id', $request->user_id)->count() > 0) {

                $map = EmployerMapData::where('user_id', $request->user_id)->first();
                $lat = $map->lat;
                $long = $map->long;
            }

            $response = array(
                'status' => 200,
                'message' => 'OK',
                'datas' => array(
                    'email' => $user->email,
                    'company_name' => $info->company_name,
                    'company_address' => $info->company_address,
                    'company_phone' => $info->company_phone,
                    'company_desc' => $info->company_desc,
                    'lat' => $lat,
                    'long' => $long,
                )
            );
            return Response($response);
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
    public function  updateProfileData(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'name' => 'required',
            'address' => 'required',
            'phone' => 'required',
            'desc' => 'required',
            'lat' => 'required',
            'long' => 'required',
        ]);

        $user = User::find($request->user_id);
        if ($user) {

            $info =  EmployeerInfo::where('user_id', $request->user_id)->first();
            $info->company_name = $request->name;
            $info->company_address = $request->address;
            $info->company_phone = $request->phone;
            $info->company_desc = $request->desc;
            $info->save();
            if (EmployerMapData::where('user_id', $request->user_id)->count() > 0) {

                $map = EmployerMapData::where('user_id', $request->user_id)->first();
                $map->lat = $request->lat;
                $map->long = $request->long;
                $map->save();
            } else {
                EmployerMapData::create([
                    'user_id' => $user->id,
                    'lat' => $request->lat,
                    'long' => $request->long,
                ]);
            }

            $response = array(
                'status' => 200,
                'message' => 'OK'
            );
            return Response($response);
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
    public function  addJobPost(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'jobtitle' => 'required',
            'jobtype' => 'required',
            'designation' => 'required',
            'qualification' => 'required',
            'specialization' => 'required',
            'skills' => 'required',
            'lastdate' => 'required',
            'desc' => 'required',
        ]);


        $user = User::find($request->user_id);
        if ($user) {

            $job = new JobPosts();
            $job->user_id = $request->user_id;
            $job->jobtitle = $request->jobtitle;
            $job->jobtype = $request->jobtype;
            $job->designation = $request->designation;
            $job->qualification = $request->qualification;
            $job->specialization = $request->specialization;
            $job->skills = $request->skills;
            $job->lastdate = $request->lastdate;
            $job->desc = $request->desc;
            $job->save();

            $response = array(
                'status' => 200,
                'message' => 'OK'
            );
            return Response($response);
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
    public function  updateJobPost(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'post_id' => 'required',
            'jobtitle' => 'required',
            'jobtype' => 'required',
            'designation' => 'required',
            'qualification' => 'required',
            'specialization' => 'required',
            'skills' => 'required',
            'lastdate' => 'required',
            'desc' => 'required',
        ]);


        $user = User::find($request->user_id);
        if ($user) {

            $job =  JobPosts::find($request->post_id);
            if ($job) {

                $job->jobtitle = $request->jobtitle;
                $job->jobtype = $request->jobtype;
                $job->designation = $request->designation;
                $job->qualification = $request->qualification;
                $job->specialization = $request->specialization;
                $job->skills = $request->skills;
                $job->lastdate = $request->lastdate;
                $job->desc = $request->desc;
                $job->save();
            }

            $response = array(
                'status' => 200,
                'message' => 'OK'
            );
            return Response($response);
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
    public function  removeJobPost(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'post_id' => 'required',
        ]);


        $user = User::find($request->user_id);
        if ($user) {

            $job =  JobPosts::find($request->post_id);
            if ($job) {
                //remove applied jobseekers
               ApplyForJobs::where('job_id', $request->post_id)->delete(); 
                $job->delete();
                $response = array(
                    'status' => 200,
                    'message' => 'OK'
                );
                return Response($response);
            }

            $response = array(
                'status' => 200,
                'message' => 'OK'
            );
            return Response($response);
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
    public function  appliedJobseekers(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'post_id' => 'required',
        ]);


        $user = User::find($request->user_id);
        if ($user) {

            $job =  JobPosts::find($request->post_id);
            if ($job) {
                $datas = array();
                foreach (ApplyForJobs::where('job_id', $request->post_id)->get() as $applcation) {

                    $jobseekerinfo = JobseekerInfo::where('user_id', $applcation->jobseeker_id)->first();
                    if ($jobseekerinfo) {

                        $cv = 'no';
                        $cvinfo = JobSeekerCv::where('jobseeker_id', $jobseekerinfo->id)->first();
                        if ($cvinfo) {
                            $cv = $cvinfo->cv;
                        }

                        array_push($datas, array(
                            'jobseeker_id' => $applcation->jobseeker_id,
                            'fullname' => $jobseekerinfo->fullname,
                            'phone_no' => $jobseekerinfo->phone_no,
                            'address' => $jobseekerinfo->address,
                            'cv' => $cv,
                        ));
                    }
                }


                $response = array(
                    'status' => 200,
                    'message' => 'OK',
                    'datas' => $datas
                );
                return Response($response);
            }

            $response = array(
                'status' => 200,
                'message' => 'OK'
            );
            return Response($response);
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
}
