<?php

namespace App\Http\Controllers\Dashboard;

use App\Http\Controllers\Controller;
use App\Models\JobSeekerCv;
use App\Models\JobseekerInfo;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class JobseekersController extends Controller
{
    public function index()
    {
        //employers
        $jobseekers = array();
        foreach (User::where('type', 'jobseeker')->orderBy('created_at')->get() as $user) {

            $info = JobseekerInfo::where('user_id', $user->id)->first();

            $cv = 'no';
            if (JobSeekerCv::where('jobseeker_id', $info->id)->count() > 0) {
                $cvinfo = JobSeekerCv::where('jobseeker_id', $info->id)->first();
                //remove old file
                $cv =$cvinfo->cv;
            }

            if ($info) {

                array_push($jobseekers, array(
                    'user_id' => $user->id,
                    'email' => $user->email,
                    'created_at' => $user->created_at,
                    'jobseekers_id' => $info->id,
                    'fullname' => $info->fullname,
                    'phone_no' => $info->phone_no,
                    'address' => $info->address,
                    'cv' => $cv,
                ));
            } else {
                $user->delete();
            }
        }
        return view('dashboard.jobseekers.index', compact('jobseekers'));
    }
    public function removeJobseeker($jobseeker_id)
    {
         $data = JobseekerInfo::find($jobseeker_id);
         if($data){
             $data->delete();
         }

         return redirect('/jobseekers');
    }
}
