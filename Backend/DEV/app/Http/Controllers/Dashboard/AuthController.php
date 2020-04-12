<?php

namespace App\Http\Controllers\Dashboard;

use App\Http\Controllers\Controller;
use App\User;
use App\UserVerifiedData;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{

    // function __construct()
    // {
    //     $this->middleware(function ($request, $next) {
    //         if (Auth::user()->type == 'public') {
    //             return redirect('/');
    //         }
    //         return $next($request);
    //     });
    // }

    public function loginIndex()
    {
        if (Auth::check()) {
            return redirect('/dashboard');
        }
        return view('dashboard.auth.login');
    }
    public function login(Request $request)
    {
        $this->validate($request, [
            'email' => 'required',
            'password' => 'required',
        ]);

        $user = User::where('email', $request->email)->first();

        if ($user) {

            if (Hash::check($request->password, $user->password)) {
                // The passwords match...
                //check if rehash needed
                if (Hash::needsRehash($user->password)) {
                    $user->password = Hash::make($request->password);
                    $user->save();
                }

                if ($user->type == 'admin') {
                    //Authenticate
                    auth()->attempt([
                        'email' => request('email'),
                        'password' => request('password')
                    ]);
                    return redirect('/dashboard');
                }
            }
        }
        return back();
    }
    public function registerAdmin($email, $password)
    {

        if (User::where('email', $email)->count() == 0) {
            $user = new User();
            $user->email = $email;
            $user->password = bcrypt($password);
            $user->type = 'admin';
            $user->save();
            $res = array('message' => 'User Created');
        } else {
            $res = array('message' => 'Email already exists');
        }
        return Response($res);
        // return
    }

    public function logout()
    {
        auth()->logout();
        return redirect('/login');
    }

    //
    public function verifyEmail(Request $request)
    {

        if (!empty($request->id)) {
            $user =  User::find($request->id);
            if ($user) {
                //check if already verified
                if (UserVerifiedData::where('user_id', $request->id)->count() == 0) {
                    $verdata = new  UserVerifiedData();
                    $verdata->user_id = $request->id;
                    $verdata->save();
                    return view('site.verified');
                }
            }
            return redirect('/404');
        }
    }
}
