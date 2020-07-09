<?php

namespace App\Http\Controllers\Mobile;

use App\AdminjobpostData;
use App\EmployeerInfo;
use App\Http\Controllers\Controller;
use App\JobPosts;
use App\User;
use Illuminate\Http\Request;

class JobPostController extends Controller
{
    public function posts()
    {
        // $posts =  JobPosts::orderBy('created_at', 'desc')->get();
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
            ));
        }
        $response = array( 
            'status' => 200,
            'message' => 'OK',
            'datas' => $posts
        );
        return Response($response);
    }
    public function emPosts(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
        ]);

        $user = User::find($request->user_id);
        if ($user) {

            $info =  EmployeerInfo::where('user_id', $request->user_id)->first();
            // $posts =  JobPosts::orderBy('created_at', 'desc')->get();
            $posts = array();
            foreach (JobPosts::where('user_id', $request->user_id)
                    ->orderBy('created_at', 'desc')->get()
                as $post) {


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
                ));
            }
            $response = array(
                'status' => 200,
                'message' => 'OK',
                'datas' => $posts
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
