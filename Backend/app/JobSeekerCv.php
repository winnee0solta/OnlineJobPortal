<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class JobSeekerCv extends Model
{
    protected $fillable = [
        'jobseeker_id',
        'cv',
    ];
}
