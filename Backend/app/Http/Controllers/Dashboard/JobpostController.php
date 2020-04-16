<?php

namespace App\Http\Controllers\Dashboard;

use App\AdminjobpostData;
use App\EmployeerInfo;
use App\Http\Controllers\Controller;
use App\JobPosts;
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

            return view('dashboard.jobposts.single',compact('post'));
        }
        return redirect('/job-posts');
    }
    public function addPostView()
    {
        return view('dashboard.jobposts.add');
    }
    public function addPost()
    {
        return redirect('/job-posts');
    }
    public function editPostView($post_id)
    {
        return view('dashboard.jobposts.edit');
    }
    public function editPost($post_id)
    {
        return redirect('/job-posts');
    }

    public function remove($post_id)
    {
        JobPosts::where('id', $post_id)->delete();
        return redirect('/job-posts');
    }
}
