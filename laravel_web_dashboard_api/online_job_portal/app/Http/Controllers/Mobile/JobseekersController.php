<?php

namespace App\Http\Controllers\Mobile;

use App\Models\ApplyForJobs;
use App\Http\Controllers\Controller;
use App\Models\JobSeekerCv;
use App\Models\JobseekerInfo;
use App\Models\User;
use App\Models\UserVerifiedData;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class JobseekersController extends Controller
{
    public function  checkVerificationStatus(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
        ]);

        $user = User::find($request->user_id);
        if ($user) {

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
                )
            );
            return Response($response);
        } else {
            $response = array(
                'status' => 401,
                'message' => 'Invalid User.',
            );
            return Response($response);
        }
    }

    public function  profileData(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
        ]);

        $user = User::find($request->user_id);
        if ($user) {

            $info =  JobseekerInfo::where('user_id', $request->user_id)->first();

            $cv = 'no';
            $cvinfo = JobSeekerCv::where('jobseeker_id', $info->id)->first();
            if ($cvinfo) {
                $cv = $cvinfo->cv;
            }
            $response = array(
                'status' => 200,
                'message' => 'OK',
                'datas' => array(
                    'email' => $user->email,
                    'fullname' => $info->fullname,
                    'phone_no' => $info->phone_no,
                    'address' => $info->address,
                    'cv' => $cv,
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
    public function  uploadCV(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
        ]);

        if (!$request->hasFile('cv')) {
            $response = array(
                'status' => 404,
                'message' => 'Cv Required.',
            );
            return Response($response);
        }

        $user = User::find($request->user_id);
        if ($user) {

            $info =  JobseekerInfo::where('user_id', $request->user_id)->first();

            if (JobSeekerCv::where('jobseeker_id', $info->id)->count() > 0) {
                $cvinfo = JobSeekerCv::where('jobseeker_id', $info->id)->first();

                //remove old file
                $cv = 'images/jobseeker/cv/' . $cvinfo->cv;
                if ($cv != 'images/jobseeker/cv/no') {
                    File::delete($cv);
                }
            } else {
                $cvinfo = new JobSeekerCv();
                $cvinfo->jobseeker_id = $info->id;
            }
            $file = $request->file('cv');
            $unique_id = uniqid();
            $filename =  $unique_id . '_' . strval($info->id) . '_cv.' . $file->getClientOriginalExtension();
            $file->move('images/jobseeker/cv', $filename);
            $cvinfo->cv =  $filename;
            $cvinfo->save();

            $response = array(
                'status' => 200,
                'message' => 'OK',
            );
            return Response($response);
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
    //
    public function  profileDataUpdate(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'fullname' => 'required',
            'phone_no' => 'required',
            'address' => 'required',
        ]);

        $user = User::find($request->user_id);
        if ($user) {

            $info =  JobseekerInfo::where('user_id', $request->user_id)->first();

            if ($info) {
                $info->fullname = $request->fullname;
                $info->phone_no = $request->phone_no;
                $info->address = $request->address;
                $info->save();
                $response = array(
                    'status' => 200,
                    'message' => 'OK',
                );
                return Response($response);
            }
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
    public function  applyForJob(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'job_id' => 'required',
        ]);

        $user = User::find($request->user_id);
        if ($user) {
            $info =  JobseekerInfo::where('user_id', $request->user_id)->first();

            if ($info) {

                //check if already applied
                if (ApplyForJobs::where('jobseeker_id', $user->id)->where('job_id', $request->job_id)->count() == 0) {

                    ApplyForJobs::create([
                        'jobseeker_id' => $user->id,
                        'job_id' => $request->job_id
                    ]);

                    $response = array(
                        'status' => 200,
                        'message' => 'Applied',
                    );
                    return Response($response);
                }
            }
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
    public function  checkIfAlreadyApplied(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'job_id' => 'required',
        ]);

        $user = User::find($request->user_id);
        if ($user) {
            $info =  JobseekerInfo::where('user_id', $request->user_id)->first();

            if ($info) {

                $applied = false;
                //check if already applied
                if (ApplyForJobs::where('jobseeker_id', $user->id)->where('job_id', $request->job_id)->count() > 0) {
                    $applied = true;
                }
                $response = array(
                    'status' => 200,
                    'message' => 'Applied',
                    'datas' => array(
                        'applied' => $applied
                    )
                );
                return Response($response);
            }
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
}
