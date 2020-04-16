<?php

namespace App\Http\Controllers\Mobile;

use App\EmployeerInfo;
use App\Http\Controllers\Controller;
use App\JobseekerInfo;
use App\PasswordResetData;
use App\User;
use App\UserVerifiedData;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;

class AuthController extends Controller
{
    public function registerJobseeker(Request $request)
    {
        //validate
        $request->validate([
            'email' => 'required',
            'password' => 'required',
            'fullname' => 'required',
            'phone_no' => 'required',
            'address' => 'required',
        ]);

        if (User::where('email', $request->email)->count() > 0) {
            $response = array(
                'status' => 404,
                'message' => 'Email Already exists.',
            );
            return Response($response);
        }

        $user = new User();
        $user->type = 'jobseeker';
        $user->email = $request->email;
        $user->password = bcrypt($request->password);
        $user->save();

        $info = new JobseekerInfo();
        $info->user_id = $user->id;
        $info->fullname = $request->fullname;
        $info->phone_no = $request->phone_no;
        $info->address = $request->address;
        $info->save();

        $this->sendEmailVerifyMail($request->email, $request->fullname, $user->id);
        $response = array(
            'status' => 200,
            'message' => 'User Created',
            'user' => $user
        );

        return Response($response);
    }
    public function registerEmployeer(Request $request)
    {
        //validate
        $request->validate([
            'email' => 'required',
            'password' => 'required',
            'company_name' => 'required',
            'company_address' => 'required',
            'company_phone' => 'required',
        ]);

        if (User::where('email', $request->email)->count() > 0) {
            $response = array(
                'status' => 404,
                'message' => 'Email Already exists.',
            );
            return Response($response);
        }

        $user = new User();
        $user->type = 'employeer';
        $user->email = $request->email;
        $user->password = bcrypt($request->password);
        $user->save();

        $info = new EmployeerInfo();
        $info->user_id = $user->id;
        $info->company_name = $request->company_name;
        $info->company_address = $request->company_address;
        $info->company_phone = $request->company_phone;
        $info->company_desc = '-';
        $info->save();

        $this->sendEmailVerifyMail($request->email, $request->company_name, $user->id);

        $response = array(
            'status' => 200,
            'message' => 'User Created',
            'user' => $user
        );

        return Response($response);
    }
    /**
     * can be used for both jobseeker & employeer
     */
    public function login(Request $request)
    {
        //validate
        $request->validate([
            'email' => 'required',
            'password' => 'required',
        ]);

        if (User::where('email', $request->email)->count() == 0) {
            $response = array(
                'status' => 404,
                'message' => 'Email dosnt exist.',
            );
            return Response($response);
        }

        $user = User::where('email', $request->email)->first();
        if ($user) {

            if (Hash::check($request->password, $user->password)) {
                // The passwords match...
                //check if rehash needed
                if (Hash::needsRehash($user->password)) {
                    $user->password = Hash::make($request->password);
                    $user->save();
                }

                $response = array(
                    'status' => 200,
                    'message' => 'OK',
                    'user' => $user
                );

                return Response($response);
            } else {
                $response = array(
                    'status' => 404,
                    'message' => 'Invalid Credentials.',
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

    public function checkEmailVerification(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
        ]);

        $user = User::find($request->user_id);
        if ($user) {

            if (UserVerifiedData::where('user_id', $request->user_id)->count() > 0) {
                //verified
                $verified = true;
            } else {
                $verified = false;
            }

            $response = array(
                'status' => 200,
                'message' => 'OK',
                'verified' => $verified
            );
            return Response($response);
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }

    //reset password
    public function resetPassword(Request $request)
    {
        //validate
        $request->validate([
            'email' => 'required',
        ]);
        $user = User::where('email', $request->email)->first();
        if ($user) {

            //token
            $digits = 5;
            $token = rand(pow(10, $digits - 1), pow(10, $digits) - 1);

            //send email with token
            if (PasswordResetData::where('user_id', $user->id)->count() > 0) {
                $data = PasswordResetData::where('user_id', $user->id)->first();
                $data->token = $token;
                $data->save();
            } else {
                $data = new PasswordResetData();
                $data->user_id = $user->id;
                $data->email = $user->email;
                $data->token = $token;
                $data->save();
            }


            $datas = array(
                'user_id' =>   $data->user_id,
                'email' =>   $data->email,
                'token' =>   $data->token,
            );

            Mail::send('mail.password-reset', $datas, function ($message) use ($datas) {
                $message->from('wtntestserver@gmail.com', 'Online Job Portal');
                $message->to($datas['email'], 'Online Job Portal');
                $message->subject('Password Reset !');
            });

            $response = array(
                'status' => 200,
                'message' => 'OK',
            );
            return Response($response);
        } else {
            $response = array(
                'status' => 404,
                'message' => 'Invalid Email.',
            );
            return Response($response);
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
    public function checkToken(Request $request)
    {
        //validate
        $request->validate([
            'email' => 'required',
            'token' => 'required',
        ]);
        $user = User::where('email', $request->email)->first();
        if ($user) {


            //send email with token
            if (PasswordResetData::where('user_id', $user->id)->where('token', $request->token)->count() > 0) {
                $response = array(
                    'status' => 200,
                    'message' => 'OK',
                );
                return Response($response);
            } else {
                $response = array(
                    'status' => 404,
                    'message' => 'Invalid Token',
                );
                return Response($response);
            }
        } else {
            $response = array(
                'status' => 404,
                'message' => 'Invalid Email.',
            );
            return Response($response);
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
    public function updatePassword(Request $request)
    {
        //validate
        $request->validate([
            'email' => 'required',
            'password' => 'required',
        ]);
        $user = User::where('email', $request->email)->first();
        if ($user) {

            $user->password = bcrypt($request->password);
            $user->save();

            $response = array(
                'status' => 200,
                'message' => 'OK',
            );
            return Response($response);
        } else {
            $response = array(
                'status' => 404,
                'message' => 'Invalid Email.',
            );
            return Response($response);
        }
        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }


    //custom function
    function sendEmailVerifyMail($email, $name, $user_id)
    {

        $data = array(
            'user_id' => $user_id
        );

        Mail::send('mail.emailverify', $data, function ($message) use ($email, $name) {
            $message->from('wtntestserver@gmail.com', 'Online Job Portal');
            $message->to($email, $name);
            $message->subject('Verify Email Address ');
        });
    }
}
