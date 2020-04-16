<?php

namespace App\Http\Controllers\Dashboard;

use App\Http\Controllers\Controller;
use App\JobseekerInfo;
use App\User;
use Illuminate\Http\Request;

class JobseekersController extends Controller
{
    public function index()
    {
        //employers
        $jobseekers = array();
        foreach (User::where('type', 'jobseeker')->orderBy('created_at')->get() as $user) {

            $info = JobseekerInfo::where('user_id', $user->id)->first();

            if ($info) {

                array_push($jobseekers, array(
                    'user_id' => $user->id,
                    'email' => $user->email,
                    'created_at' => $user->created_at,
                    'jobseekers_id' => $info->id,
                    'fullname' => $info->fullname,
                    'phone_no' => $info->phone_no,
                    'address' => $info->address,
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
