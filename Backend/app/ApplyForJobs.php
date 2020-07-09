<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ApplyForJobs extends Model
{
    protected $fillable = [
        'jobseeker_id',
        'job_id', 
    ];
} 