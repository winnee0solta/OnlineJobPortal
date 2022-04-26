<?php

namespace App\Http\Controllers\Dashboard;

use App\Models\EmployeerInfo;
use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\VerifiedEmployers;
use Illuminate\Http\Request;

class EmployersController extends Controller
{
    public function index()
    {
        //employers
        $employers = array();
        foreach (User::where('type', 'employeer')->orderBy('created_at')->get() as $user) {

            $employer = EmployeerInfo::where('user_id', $user->id)->first();

            if ($employer) {
                $isverified = false;
                if (VerifiedEmployers::where('user_id', $user->id)->count() > 0) {
                    $isverified = true;
                }

                array_push($employers, array(
                    'user_id' => $user->id,
                    'email' => $user->email,
                    'created_at' => $user->created_at,
                    'employer_id' => $employer->id,
                    'company_name' => $employer->company_name,
                    'company_address' => $employer->company_address,
                    'company_phone' => $employer->company_phone,
                    'company_desc' => $employer->company_desc,
                    'isverified' => $isverified,
                ));
            } else {
                $user->delete();
            }
        }
        return view('dashboard.employers.index', compact('employers'));
    }

    public function verifyEmployer($employer_id)
    {
        $employer = EmployeerInfo::find($employer_id);
        if ($employer) {

            if (VerifiedEmployers::where('user_id', $employer->user_id)->count() == 0) {
                VerifiedEmployers::create([
                    'user_id' => $employer->user_id
                ]);
            }
        }
        return redirect('/employers');
    }
    public function unverifyEmployer($employer_id)
    {
        $employer = EmployeerInfo::find($employer_id);
        if ($employer) {

            if (VerifiedEmployers::where('user_id', $employer->user_id)->count() > 0) {
                VerifiedEmployers::where('user_id', $employer->user_id)->delete();
            }
        }
        return redirect('/employers');
    }
    public function removeEmployer($employer_id)
    {
        $employer = EmployeerInfo::find($employer_id);
        if ($employer) {

            if (VerifiedEmployers::where('user_id', $employer->user_id)->count() > 0) {
                VerifiedEmployers::where('user_id', $employer->user_id)->delete();
            }
            $user = User::find($employer->userId);
            $user->delete();
            $employer->delete();
        }
        return redirect('/employers');
    }
}
