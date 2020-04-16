<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEmployeerInfosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('employeer_infos', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('user_id');
            $table->string('company_name');
            $table->string('company_address');
            $table->string('company_phone');
            $table->longText('company_desc');
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
        Schema::dropIfExists('employeer_infos');
    }
}
