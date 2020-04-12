<?php

namespace App\Http\Controllers\Mobile;

use App\Http\Controllers\Controller;
use App\User;
use App\UserVerifiedData;
use Illuminate\Http\Request;

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
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
}
