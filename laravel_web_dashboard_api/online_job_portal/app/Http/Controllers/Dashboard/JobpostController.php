<?php

namespace App\Http\Controllers\Dashboard;

use App\Models\AdminjobpostData;
use App\Models\ApplyForJobs;
use App\Models\EmployeerInfo;
use App\Http\Controllers\Controller;
use App\Models\JobPosts;
use App\Models\JobSeekerCv;
use App\Models\JobseekerInfo;
use Illuminate\Http\Request;

class JobpostController extends Controller
{
    public function index()
    {
        $posts = array();
        foreach (JobPosts::orderBy('created_at', 'desc')->get() as $post) {


            if ($post->admin_post) {
                if (AdminjobpostData::where('post_id', $post->id)->count() == 0) {
                    $post->delete();
                    continue;
                }
                $info = AdminjobpostData::where('post_id', $post->id)->first();
                $company_name =  $info->company_name;
                $company_address =  $info->company_address;
                $company_phone =  $info->company_phone;
            } else {
                if (EmployeerInfo::where('user_id', $post->user_id)->count() == 0) {
                    $post->delete();
                    continue;
                }
                $info =  EmployeerInfo::where('user_id', $post->user_id)->first();
                $company_name =  $info->company_name;
                $company_address =  $info->company_address;
                $company_phone =  $info->company_phone;
            }

            array_push($posts, array(
                'post_id' => $post->id,
                'admin_post' => $post->admin_post,
                'company_name' => $company_name,
                'company_address' => $company_address,
                'company_phone' => $company_phone,
                'jobtitle' => $post->jobtitle,
                'jobtype' => $post->jobtype,
                'designation' => $post->designation,
                'qualification' => $post->qualification,
                'specialization' => $post->specialization,
                'skills' => $post->skills,
                'lastdate' => $post->lastdate,
                'desc' => $post->desc,
                'created_at' => $post->created_at,
            ));
        }
        return view('dashboard.jobposts.index', compact('posts'));
    }

    public function viewPost($post_id)
    {
        $rpost = JobPosts::find($post_id);
        if ($rpost) {


            if ($rpost->admin_post) {
                if (AdminjobpostData::where('post_id', $rpost->id)->count() == 0) {
                    $rpost->delete();
                }
                $info = AdminjobpostData::where('post_id', $rpost->id)->first();
                $company_name =  $info->company_name;
                $company_address =  $info->company_address;
                $company_phone =  $info->company_phone;
            } else {
                if (EmployeerInfo::where('user_id', $rpost->user_id)->count() == 0) {
                    $rpost->delete();
                }
                $info =  EmployeerInfo::where('user_id', $rpost->user_id)->first();
                $company_name =  $info->company_name;
                $company_address =  $info->company_address;
                $company_phone =  $info->company_phone;
            }

            $post = array(
                'post_id' => $rpost->id,
                'admin_post' => $rpost->admin_post,
                'company_name' => $company_name,
                'company_address' => $company_address,
                'company_phone' => $company_phone,
                'jobtitle' => $rpost->jobtitle,
                'jobtype' => $rpost->jobtype,
                'designation' => $rpost->designation,
                'qualification' => $rpost->qualification,
                'specialization' => $rpost->specialization,
                'skills' => $rpost->skills,
                'lastdate' => $rpost->lastdate,
                'desc' => $rpost->desc,
                'created_at' => $rpost->created_at,
            );

            $appliedjobseekers = array();
            foreach (ApplyForJobs::where('job_id', $rpost->id)->get() as $applcation) {
                $jobseekerinfo = JobseekerInfo::where('user_id', $applcation->jobseeker_id)->first();
                if ($jobseekerinfo) {

                    $cv = 'no';
                    $cvinfo = JobSeekerCv::where('jobseeker_id', $jobseekerinfo->id)->first();
                    if ($cvinfo) {
                        $cv = $cvinfo->cv;
                    }

                    array_push($appliedjobseekers, array(
                        'jobseeker_id' => $applcation->jobseeker_id,
                        'created_at' => $applcation->created_at,
                        'fullname' => $jobseekerinfo->fullname,
                        'phone_no' => $jobseekerinfo->phone_no,
                        'address' => $jobseekerinfo->address,
                        'cv' => $cv,
                    ));
                }
            }


            return view('dashboard.jobposts.single', compact('post', 'appliedjobseekers'));
        }
        return redirect('/job-posts');
    }
    public function addPost(Request $request)
    {
        //validate
        $request->validate([
            'jobtitle' => 'required',
            'jobtype' => 'required',
            'designation' => 'required',
            'qualification' => 'required',
            'specialization' => 'required',
            'skills' => 'required',
            'lastdate' => 'required',
            'desc' => 'required',
            'company_name' => 'required',
            'company_address' => 'required',
            'company_phone' => 'required',
        ]);



        $job = new JobPosts();
        $job->user_id = 0;
        $job->admin_post = true;
        $job->jobtitle = $request->jobtitle;
        $job->jobtype = $request->jobtype;
        $job->designation = $request->designation;
        $job->qualification = $request->qualification;
        $job->specialization = $request->specialization;
        $job->skills = $request->skills;
        $job->lastdate = $request->lastdate;
        $job->desc = $request->desc;
        $job->save();

        $adminpost = new AdminjobpostData();
        $adminpost->post_id = $job->id;
        $adminpost->company_name = $request->company_name;
        $adminpost->company_address = $request->company_address;
        $adminpost->company_phone = $request->company_phone;
        $adminpost->save();

        return redirect('/job-posts');
    }
    public function editPost($post_id, Request $request)
    {
        //validate
        $request->validate([
            'jobtitle' => 'required',
            'jobtype' => 'required',
            'designation' => 'required',
            'qualification' => 'required',
            'specialization' => 'required',
            'skills' => 'required',
            'lastdate' => 'required',
            'desc' => 'required',
        ]);



        $job =  JobPosts::find($post_id);
        $job->jobtitle = $request->jobtitle;
        $job->jobtype = $request->jobtype;
        $job->designation = $request->designation;
        $job->qualification = $request->qualification;
        $job->specialization = $request->specialization;
        $job->skills = $request->skills;
        $job->lastdate = $request->lastdate;
        $job->desc = $request->desc;
        $job->save();

        if ($job->admin_post) {

            $adminpost = AdminjobpostData::where('post_id', $job->id)->first();
            $adminpost->post_id = $job->id;
            $adminpost->company_name = $request->company_name;
            $adminpost->company_address = $request->company_address;
            $adminpost->company_phone = $request->company_phone;
            $adminpost->save();
        }

        return redirect('/job-posts');
    }

    public function remove($post_id)
    {
        $job =  JobPosts::find($post_id);
        if ($job) {
            if ($job->admin_post) {
                AdminjobpostData::where('post_id', $job->id)->delete();
            }
            $job->delete();
        }
        return redirect('/job-posts');
    }
}
