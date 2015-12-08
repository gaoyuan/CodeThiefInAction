<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateVideoProfilesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('video_profiles', function (Blueprint $table) {
            $table->increments('Vid'); 
            $table->string('Vname');
            $table->string('FileName');
            $table->string('KeyFrame', 1000);
            $table->Integer('User_id');
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
        Schema::drop('video_profiles');
    }
}
