<?php

use App\Http\Controllers\Dashboard\AuthController;
use App\Http\Controllers\Dashboard\EmployersController;
use App\Http\Controllers\Dashboard\HomeController;
use App\Http\Controllers\Dashboard\JobpostController;
use App\Http\Controllers\Dashboard\JobseekersController;
use Illuminate\Support\Facades\Route;


Route::get('/', function () {
    return redirect('/login');
});

Route::middleware(['auth'])->group(function () {

    Route::get('/dashboard', [HomeController::class,"index"]  );

    // employers
    Route::get('/employers', [EmployersController::class,"index"]  );
    Route::get('/employers/{employer_id}/verify', [EmployersController::class, "verifyEmployer"]  );
    Route::get('/employers/{employer_id}/unverify', [EmployersController::class, "unverifyEmployer"]  );
    Route::get('/employers/{employer_id}/remove', [EmployersController::class, "removeEmployer"]  );
    // jobseekers
    Route::get('/jobseekers', [JobseekersController::class, "index"]  );
    Route::get('/jobseekers/{jobseeker_id}/remove', [JobseekersController::class, "removeJobseeker"]  );


    Route::get('/job-posts', [JobpostController::class, "index"]  );
    Route::post('/job-posts/add', [JobpostController::class, "addPost"]  );
    Route::get('/job-posts/{post_id}/view', [JobpostController::class, "viewPost"]  );
    Route::post('/job-posts/{post_id}/edit', [JobpostController::class, "editPost"]  );
    Route::get('/job-posts/{post_id}/remove', [JobpostController::class, "remove"]  );

});




/*
|--------------------------------------------------------------------------
| AUTH Routes
|--------------------------------------------------------------------------
*/
Route::get('/login', [AuthController::class, "loginIndex"]);
Route::post('/login', [AuthController::class, "login"]);
Route::get('/logout', [AuthController::class, "logout"])->middleware(['auth']);
Route::get('/verify-email', [AuthController::class, "verifyEmail"]);
