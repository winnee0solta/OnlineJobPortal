<?php

use App\Http\Controllers\Dashboard\AuthController;
use App\Http\Controllers\Mobile\AuthController as MobileAuthController;
use App\Http\Controllers\Mobile\EmployersController;
use App\Http\Controllers\Mobile\JobPostController;
use App\Http\Controllers\Mobile\JobseekersController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


/*
|--------------------------------------------------------------------------
| AUTH Routes
|--------------------------------------------------------------------------
*/

Route::get('/register-admin/{email}/{password}', [AuthController::class, "registerAdmin"]);




/*
|--------------------------------------------------------------------------
| Mobile Routes
|--------------------------------------------------------------------------
*/
Route::post('/register-jobseeker', [MobileAuthController::class, "registerJobseeker"]);
Route::post('/register-employeer', [MobileAuthController::class, "registerEmployeer"]);
Route::post('/login', [MobileAuthController::class, "login"]);
Route::post('/reset-password', [MobileAuthController::class, "resetPassword"]);
Route::post('/check-token', [MobileAuthController::class, "checkToken"]);
Route::post('/update-password', [MobileAuthController::class, "updatePassword"]);
Route::post('/email-verification', [MobileAuthController::class, "checkEmailVerification"]);







Route::get('/job-posts', [JobPostController::class, "posts"]);

/*
|--------------------------------------------------------------------------
| js -jobseeker
|--------------------------------------------------------------------------
*/

Route::post('/jobseeker-verification', [JobseekersController::class, "checkVerificationStatus"]);
Route::post('/jobseeker-profile-data', [JobseekersController::class, "profileData"]);
Route::post('/jobseeker-profile-data/update', [JobseekersController::class, "profileDataUpdate"]);
Route::post('/jobseeker-upload-cv',  [JobseekersController::class, "uploadCV"]);
Route::post('/jobseeker/apply-for-job', [JobseekersController::class, "applyForJob"]);
Route::post('/jobseeker/job/check-if-already-applied', [JobseekersController::class, "checkIfAlreadyApplied"]);
/*
|--------------------------------------------------------------------------
| em - employer
|--------------------------------------------------------------------------
*/

Route::post('/employer-verification', [EmployersController::class, "checkVerificationStatus"]);
Route::post('/employer-profile-data', [EmployersController::class, "profileData"]);
Route::post('/employer-profile-data-update', [EmployersController::class, "updateProfileData"]);
Route::post('/employer-add-job-post', [EmployersController::class, "addJobPost"]);
Route::post('/employer-update-job-post', [EmployersController::class, "updateJobPost"]);
Route::post('/employer-remove-job-post', [EmployersController::class, "removeJobPost"]);

Route::post('/employer-job-posts', [JobPostController::class, "emPosts"]);
Route::post('/employer/job/applied-jobseekers', [EmployersController::class, "appliedJobseekers"]);
