<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class AdminUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $user = new User();
        $user->email = 'root@onlinejobportal.com';
        $user->password = bcrypt('secret!@#123');
        $user->type = 'admin';
        $user->save();
    }
}
