<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // \App\Models\User::factory(10)->create();
        DB::table('otps')->insert([
            'identifier' => "+963962256897",
            'token'=>"0000",
            'validity'=>0,
            'valid'=>1
            // يمكنك إضافة أي أعمدة أخرى تحتاجها هنا
        ]);
        DB::table('users')->insert([
            'name' =>"أبي موسى " ,
            'otp_id' => 1,
            'date_of_birth' => "2002-10-16",
            'gender' => "male",
            'password' => Hash::make("111q"),
            'role'=> 1
        ]);  
        DB::table('r_statuses')->insert([
            ['title' => 'جارٍ الإرسال'],
            ['title' => 'تم استلام طلبك'],
            ['title' => ' تم الانتهاء بدون ملاحظة'],
            ['title' => ' تم الانتهاء مع ملاحظة'],
        ]); 
    }
}
