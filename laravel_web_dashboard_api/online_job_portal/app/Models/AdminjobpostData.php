<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AdminjobpostData extends Model
{
    protected $fillable = [
        'post_id',
        'company_name',
        'company_address',
        'company_phone',
    ];
}
