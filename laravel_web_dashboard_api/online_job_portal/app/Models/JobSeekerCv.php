<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JobSeekerCv extends Model
{
    protected $fillable = [
        'jobseeker_id',
        'cv',
    ];
}
