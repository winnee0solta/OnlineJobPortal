<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});


/*
|--------------------------------------------------------------------------
| AUTH Routes
|--------------------------------------------------------------------------
*/
Route::get('/register-admin/{email}/{password}', 'Dashboard\AuthController@registerAdmin');




/*
|--------------------------------------------------------------------------
| Mobile Routes
|--------------------------------------------------------------------------
*/
Route::post('/register-jobseeker', 'Mobile\AuthController@registerJobseeker');
Route::post('/register-employeer', 'Mobile\AuthController@registerEmployeer');

Route::post('/login', 'Mobile\AuthController@login');
Route::post('/reset-password', 'Mobile\AuthController@resetPassword');
Route::post('/check-token', 'Mobile\AuthController@checkToken');
Route::post('/update-password', 'Mobile\AuthController@updatePassword');

Route::post('/email-verification', 'Mobile\AuthController@checkEmailVerification');



 


Route::get('/job-posts', 'Mobile\JobPostController@posts');

/*
|--------------------------------------------------------------------------
| js -jobseeker
|--------------------------------------------------------------------------
*/
Route::post('/jobseeker-verification', 'Mobile\JobseekersController@checkVerificationStatus');
Route::post('/jobseeker-profile-data', 'Mobile\JobseekersController@profileData');
Route::post('/jobseeker-profile-data/update', 'Mobile\JobseekersController@profileDataUpdate');
Route::post('/jobseeker-upload-cv', 'Mobile\JobseekersController@uploadCV');
Route::post('/jobseeker/apply-for-job', 'Mobile\JobseekersController@applyForJob');
Route::post('/jobseeker/job/check-if-already-applied', 'Mobile\JobseekersController@checkIfAlreadyApplied');
/*
|--------------------------------------------------------------------------
| em - employer
|--------------------------------------------------------------------------
*/
 
Route::post('/employer-verification', 'Mobile\EmployersController@checkVerificationStatus');
Route::post('/employer-profile-data', 'Mobile\EmployersController@profileData');
Route::post('/employer-profile-data-update', 'Mobile\EmployersController@updateProfileData');
Route::post('/employer-add-job-post', 'Mobile\EmployersController@addJobPost');
Route::post('/employer-update-job-post', 'Mobile\EmployersController@updateJobPost');
Route::post('/employer-remove-job-post', 'Mobile\EmployersController@removeJobPost');
Route::post('/employer-job-posts', 'Mobile\JobPostController@emPosts');
Route::post('/employer/job/applied-jobseekers', 'Mobile\EmployersController@appliedJobseekers');
