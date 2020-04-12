<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class JobseekerInfo extends Model
{
    protected $fillable = [
        'user_id',
        'fullname',
        'phone_no',
        'address',
    ];
}
