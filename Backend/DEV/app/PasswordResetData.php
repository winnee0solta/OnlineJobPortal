<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PasswordResetData extends Model
{
    protected $fillable = [
        'user_id',
        'email',
        'token',
    ];
}
