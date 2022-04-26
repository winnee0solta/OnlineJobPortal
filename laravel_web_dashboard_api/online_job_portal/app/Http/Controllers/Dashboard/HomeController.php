<?php

namespace App\Http\Controllers\Dashboard;

use App\Models\EmployeerInfo;
use App\Http\Controllers\Controller;
use App\Models\JobPosts;
use App\Models\JobseekerInfo;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    public function index()
    {
        $jobpostcount = JobPosts::count();
        $jobseekerscount = JobseekerInfo::count();
        $employeercount = EmployeerInfo::count();
        return view('dashboard.home.index',compact(
            'jobpostcount',
            'jobseekerscount',
            'employeercount'
        ));
    }
}
