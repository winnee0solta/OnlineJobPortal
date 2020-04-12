<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
*/

Route::get('/', function(){
    return redirect('/login');
});


Route::middleware(['auth'])->group(function () {

    Route::get('/dashboard', 'Dashboard\HomeController@index');
    // employers
    Route::get('/employers', 'Dashboard\EmployersController@index');
    Route::get('/employers/{employer_id}/verify', 'Dashboard\EmployersController@verifyEmployer');
    Route::get('/employers/{employer_id}/unverify', 'Dashboard\EmployersController@unverifyEmployer');
    Route::get('/employers/{employer_id}/remove', 'Dashboard\EmployersController@removeEmployer');
    // jobseekers
    Route::get('/jobseekers', 'Dashboard\JobseekersController@index');
    Route::get('/jobseekers/{jobseeker_id}/remove', 'Dashboard\JobseekersController@removeJobseeker');

});




/*
|--------------------------------------------------------------------------
| AUTH Routes
|--------------------------------------------------------------------------
*/
Route::get('/login', 'Dashboard\AuthController@loginIndex');
Route::post('/login', 'Dashboard\AuthController@login');
Route::get('/logout', 'Dashboard\AuthController@logout')->middleware(['auth']);

Route::get('/verify-email', 'Dashboard\AuthController@verifyEmail');
