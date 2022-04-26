<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JobPosts extends Model
{
    protected $fillable = [
        'user_id',
        'admin_post',
        'jobtitle',
        'jobtype',
        'designation',
        'qualification',
        'specialization',
        'skills',
        'lastdate',
        'desc',
    ];
}
