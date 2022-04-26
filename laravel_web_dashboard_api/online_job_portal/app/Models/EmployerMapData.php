<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EmployerMapData extends Model
{
    protected $fillable = [
        'user_id',
        'lat',
        'long',
    ];
}
