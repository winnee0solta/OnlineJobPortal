<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateJobPostsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('job_posts', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('user_id'); //emloyeers id
            $table->boolean('admin_post')->default(false);
            $table->string('jobtitle');
            $table->string('jobtype');
            $table->string('designation');
            $table->string('qualification');
            $table->string('specialization');
            $table->string('skills');
            $table->string('lastdate');
            $table->longText('desc');
            $table->timestamps();
        });
    }
    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('job_posts');
    }
}
