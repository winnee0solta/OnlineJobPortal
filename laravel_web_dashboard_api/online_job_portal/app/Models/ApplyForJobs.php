<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ApplyForJobs extends Model
{
    protected $fillable = [
        'jobseeker_id',
        'job_id',
    ];
}
