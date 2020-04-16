<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EmployeerInfo extends Model
{
    protected $fillable = [
        'user_id',
        'company_name',
        'company_address',
        'company_phone',
        'company_desc',
    ];
}
