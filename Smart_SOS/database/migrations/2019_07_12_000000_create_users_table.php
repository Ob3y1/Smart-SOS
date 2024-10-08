<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->unsignedInteger('otp_id');
            $table->foreign('otp_id')->references('id')->on('otps')->onDelete('cascade');
            $table->date('date_of_birth')->nullable();
            $table->string('gender')->nullable();
            $table->string('password');
            $table->rememberToken();
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
        Schema::dropIfExists('users');
    }
}
